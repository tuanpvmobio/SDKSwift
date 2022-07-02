//
//  ViewControllerLifecycle.swift
//  AppDemo
//
//  Created by LinhNobi on 21/09/2021.
//

import UIKit

// MARK: - Declaration
public protocol ViewControllerLifeCycleBehavior {
    func afterLoading(_ viewController: UIViewController)
    func beforeAppearing(_ viewController: UIViewController)
    func afterAppearing(_ viewController: UIViewController)
    func beforeDisappearing(_ viewController: UIViewController)
    func afterDisappearing(_ viewController: UIViewController)
    func beforeLayingOutSubviews(_ viewController: UIViewController)
    func afterLayingOutSubviews(_ viewController: UIViewController)
}

// MARK: - Default implementation
extension ViewControllerLifeCycleBehavior {
    func afterLoading(_ viewController: UIViewController) {}
    func beforeAppearing(_ viewController: UIViewController) {}
    func afterAppearing(_ viewController: UIViewController) {}
    func beforeDisappearing(_ viewController: UIViewController) {}
    func afterDisappearing(_ viewController: UIViewController) {}
    func beforeLayingOutSubviews(_ viewController: UIViewController) {}
    func afterLayingOutSubviews(_ viewController: UIViewController) {}
}

// MARK: - UIViewController + Lifecycle Behavior
public extension UIViewController {
    
    final class LifeCycleBehaviorViewController: UIViewController {
        
        private let behaviors: [ViewControllerLifeCycleBehavior]
        weak var timer:Timer?
        var countTime: Int = 0
        let trackingRepository = TrackingRepository(api: HTTPClient.shared)
        let screenSettingManager = ScreenSettingManager()
        
        init(behaviors: [ViewControllerLifeCycleBehavior]) {
            self.behaviors = behaviors
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        public override func viewDidLoad() {
            super.viewDidLoad()
            view.isHidden = true
            timer = nil
            applyBehaviors { $0.afterLoading($1) }
        }
        
        public override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            applyBehaviors { $0.beforeAppearing($1) }
        }
        
        public override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            applyBehaviors { $0.afterAppearing($1) }
            self.timer?.invalidate()
            self.timer = nil
            self.countTime = 0
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
            
            //
            screenStart(eventKey: "sdk_mobile_test_screen_start_in_app")
            //            let configScreens = getConfigAllScreen()
            //            print("configScreens \(configScreens)")
        }
        
        public override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            applyBehaviors { $0.beforeDisappearing($1) }
            
            let screenName = UserDefaultManager.getString(forKey: "m_screen_current_view")
            UserDefaultManager.set(value: screenName, forKey: "m_screen_exit_view")
            UserDefaults.standard.synchronize()
            //            screenEnd(eventKey: "sdk_mobile_test_screen_end_in_app")
            print("viewWillDisappear")
        }
        
        public override func viewDidDisappear(_ animated: Bool) {
            super.viewDidDisappear(animated)
            applyBehaviors { $0.afterDisappearing($1) }
            print("viewDidDisappear")
            
            self.timer?.invalidate()
        }
        
        public override func viewWillLayoutSubviews() {
            super.viewWillLayoutSubviews()
            applyBehaviors { $0.beforeLayingOutSubviews($1) }
        }
        
        public override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            applyBehaviors { $0.afterLayingOutSubviews($1) }
        }
        
        private func applyBehaviors(
            handler: (_ behavior: ViewControllerLifeCycleBehavior, _ viewController: UIViewController) -> Void
        ) {
            guard let parentViewController = parent else { return }
            behaviors.forEach { handler($0, parentViewController) }
            self.timer?.invalidate()
            self.timer = nil
        }
        
        private func getControllerName() -> String {
            let topVC = UIApplication.getTopViewController()
            let className = NSStringFromClass(topVC!.classForCoder)
            let appName = Bundle.main.infoDictionary?["CFBundleName"] as? String
            var controllerName = className.replacingOccurrences(of: appName!, with: "", options: NSString.CompareOptions.literal, range:nil)
            controllerName = controllerName.replacingOccurrences(of: ".", with: "", options: NSString.CompareOptions.literal, range:nil)
            return controllerName
        }
        
        private func getScreenView(controllerName: String, screens: Set<ScreenSetting>) -> [ScreenSetting] {
            var result: Array<ScreenSetting> = []
            for screen in screens {
                if screen.controllerName == controllerName {
                    result = [screen]
                }
            }
            return result
        }
        
        @objc private func timerAction() {
            countTime += 1
            
            let configScreens = screenSettingManager.getConfigScreen()
            
            if configScreens.count == 0 {
                self.timer?.invalidate()
                return
            }
            
            let controllerName = getControllerName()
            
            let screenView = getScreenView(controllerName: controllerName, screens: configScreens)
            //            let screenView = UserDefaults.standard.array(forKey: "m_screen_config_view") as? [ScreenSetting]
            //            print(" screenView \(screenView)")
            //            let encodedData = UserDefaults.standard.array(forKey: ScreenSettingUserDefaults)
            
            //            encodedData.map { try! JSONDecoder().decode(ScreenSetting.self, from: $0) }
            
            
            if screenView.count == 0 {
                //                self.timer?.invalidate()
                return
            }
            
            let timeConfig = screenView[0].timeVisit
            if timeConfig.count == 0 {
                self.timer?.invalidate()
                return
            }
            
            for time in timeConfig {
                if countTime == time {
                    let traits: MobioSDK.Dictionary = [
                        "time_visit": countTime,
                        "screen_name": screenView[0].title,
                    ]
                    NotificationCenter.default.post(name: .sendEvent, object: traits)
                    trackingRepository.getTrackingData(event: "sdk_mobile_test_time_visit_app", properties: [traits])
                    
                }
                //                
                if countTime == timeConfig[timeConfig.count - 1] {
                    self.timer?.invalidate()
                }
                //            }
                // Khởi tạo lại giá trị countTime khi quay lại màn hình
                if countTime > timeConfig[timeConfig.count - 1] {
                    //                countTime = 0
                }
            }
        }
        
        private func screenStart(eventKey: String) {
            let configScreens = screenSettingManager.getConfigScreen()
            
            if configScreens.count == 0 {
                return
            }
            
            let controllerName = getControllerName()
            let screenView = getScreenView(controllerName: controllerName, screens: configScreens)
            if screenView.count == 0 {
                return
            }
            UserDefaultManager.set(value: screenView[0].title, forKey: "m_screen_current_view")
            UserDefaults.standard.synchronize()
            
            let properties: MobioSDK.Dictionary = [
                "time": Date().iso8601(),
                "screen_name": screenView[0].title,
            ]
            trackingRepository.getTrackingData(event: eventKey, properties: [properties])
            
        }
        
        private func screenEnd(eventKey: String) {
            
            let screenName = UserDefaultManager.getString(forKey: "m_screen_current_view")
            let properties: MobioSDK.Dictionary = [
                "time": Date().iso8601(),
                "screen_name": screenName ,
            ]
            trackingRepository.getTrackingData(event: eventKey, properties: [properties])
        }
    }
    
    func addBehaviors(_ behaviors: [ViewControllerLifeCycleBehavior]) {
        let behaviorVC = LifeCycleBehaviorViewController(behaviors: behaviors)
        addChild(behaviorVC)
        view.addSubview(behaviorVC.view)
        behaviorVC.didMove(toParent: self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        print("chạm \(touches.hashValue)")
    }
}


extension UIApplication {
    
    class func getTopViewController(base: UIViewController? = UIApplication.shared.delegate?.window??.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.topViewController)
            
        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)
            
        } else if let presented = base?.presentedViewController {
            
            if presented.view.tag == 1000 {
                return base
            }
            
            return getTopViewController(base: presented)
        }
        return base
    }
}
