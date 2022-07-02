//
//  iOSLifecycleEvents.swift
//
//  Created by LinhNobi on 24/08/2021.
//

import Foundation
import UIKit

class iOSLifecycleEvents: NSObject , UIApplicationDelegate {
    
    static let shared = iOSLifecycleEvents()
    let viewModel = iOSLifecycleEventsViewModel()
    let mobioRemoteNotification = MobioRemoteNotification()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        viewModel.didFinishLaunching()
        let urlString = "https://test38.mobio.vn/624aa6e8365e1f7a2b81165c.html"
        showHTMLPopup(urlString: urlString)
        return true
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        print("vào applicationWillEnterForeground")
        // Application Opened - from background
        setupRemoteNotification()
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Application Backgrounded
        print("vào applicationDidEnterBackground")
    }
    
    private func setupRemoteNotification() {
        mobioRemoteNotification.registerForPushNotifications()
        let remoteNotificationViewModel = RemoteNotificationViewModel()
        mobioRemoteNotification.bindViewModel(to: remoteNotificationViewModel)
    }
}

extension iOSLifecycleEvents: Navigationable {
    func showHTMLPopup(urlString: String) {
        let webPopupNavigator = WebPopupNavigator()
        let webPopupUseCase = WebPopupUseCase()
        let viewModel = WebPopupViewModel(urlString: urlString,
                                          navigator: webPopupNavigator,
                                          useCase: webPopupUseCase)
        let webviewController = WebPopupViewController()
        print("------ debug ------- iOSLifecycleEventsNavigator")
        webviewController.bindViewModel(webPopupViewModel: viewModel)
        webviewController.modalPresentationStyle = .overFullScreen
        navigationController?.present(webviewController, animated: true, completion: nil)
    }
}
