//
//  iOSLifecycleMonitor.swift
//
//  Created by LinhNobi on 27/08/2021.
//

import Foundation
import UIKit

class iOSLifecycleMonitor {

    private var application = UIApplication.shared
    private var appNotifications = [UIApplication.didEnterBackgroundNotification,
                                    UIApplication.willEnterForegroundNotification,
                                    UIApplication.didFinishLaunchingNotification,
                                    UIApplication.didBecomeActiveNotification,
                                    UIApplication.willResignActiveNotification,
                                    UIApplication.didReceiveMemoryWarningNotification,
                                    UIApplication.willTerminateNotification,
                                    UIApplication.significantTimeChangeNotification,
                                    UIApplication.backgroundRefreshStatusDidChangeNotification]
    lazy var myLocalNotificaion = MyLocalNotification()
    private var event: Event!
    lazy var observerBackend = ObserverBackend()
    
    init() {
        setupObserverBackend()
    }
    
    func setupListeners() {
        // Configure the current life cycle events
        let notificationCenter = NotificationCenter.default
        for notification in appNotifications {
            notificationCenter.addObserver(self, selector: #selector(notificationResponse(notification:)), name: notification, object: application)
        }
    }
    
    @objc
    func notificationResponse(notification: NSNotification) {
        
        switch (notification.name) {
        case UIApplication.didEnterBackgroundNotification:
            self.didEnterBackground(notification: notification)
        case UIApplication.willEnterForegroundNotification:
            self.applicationWillEnterForeground(notification: notification)
        case UIApplication.didFinishLaunchingNotification:
            self.didFinishLaunching(notification: notification)
        case UIApplication.didBecomeActiveNotification:
            //            self.didBecomeActive(notification: notification)
            print("didBecomeActive")
        case UIApplication.willResignActiveNotification:
            //            self.willResignActive(notification: notification)
            print("willResignActive")
        case UIApplication.didReceiveMemoryWarningNotification:
            //            self.didReceiveMemoryWarning(notification: notification)
            print("didReceiveMemoryWarning")
        case UIApplication.significantTimeChangeNotification:
            //            self.significantTimeChange(notification: notification)
            print("significantTimeChange")
        case UIApplication.backgroundRefreshStatusDidChangeNotification:
            //            self.backgroundRefreshDidChange(notification: notification)
            print("backgroundRefreshDidChange")
        case UIApplication.willTerminateNotification:
            print("------ debug ---------- iOSLifecycleMonitor --------  applicationWillTerminate")
            setupGoldTime()
            break
        default:
            break
        }
    }
    
    private func setupGoldTime() {
        let startTimeOne = Time(hour: 15, minute: 8)
        let endTimeOne = Time(hour: 15, minute: 30)
        let goldTimeOne = GoldTime(startTime: startTimeOne, endTime: endTimeOne)
        
        let startTimeTwo = Time(hour: 14, minute: 45)
        let endTimeTwo = Time(hour: 17, minute: 30)
        let goldTimeTwo = GoldTime(startTime: startTimeTwo, endTime: endTimeTwo)
        
        let goldTimeArray = [goldTimeOne, goldTimeTwo]
        
        goldTimeArray.forEach { goldTime in
            if goldTime.isGoldTime() {
                // MARK: - To do
                //                terminateAction()
                return
            }
        }
        terminateAction()
    }
    
    func didEnterBackground(notification: NSNotification) {
        setupGoldTime()
        iOSLifecycleEvents.shared.applicationDidEnterBackground(self.application)
    }
    
    func applicationWillEnterForeground(notification: NSNotification) {
        iOSLifecycleEvents.shared.applicationWillEnterForeground(self.application)
    }
    
    func didFinishLaunching(notification: NSNotification) {
        let options = notification.userInfo as? [UIApplication.LaunchOptionsKey: Any] ?? nil
        _ = iOSLifecycleEvents.shared.application(self.application, didFinishLaunchingWithOptions: options)
    }
}

extension iOSLifecycleMonitor {
    
    private func terminateAction() {
        if event == nil {
            return
        }
        let pushArray = event.findDataPushArray()
        for index in 0..<pushArray.count {
            let push = pushArray[index]
            let notifData = push.notiResponse
            let notifContent = NotificationContent(title: notifData.title, body: notifData.content, pushID: push.nodeID)
            let timeInterval = TimeInterval(index * 5) + 1
            myLocalNotificaion.pushNotif(with: notifContent, after: timeInterval)
            observerBackend.pushRepository.pushIsShowed(push.nodeID)
        }
    }
    
    private func setupObserverBackend() {
        observerBackend.startListenEvent()
        observerBackend.passEvent = { [weak self] in
            guard let self = self else { return }
            self.event = $0
        }
    }
}
