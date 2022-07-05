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
        return true
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        setupRemoteNotification()
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
    }
    
    private func setupRemoteNotification() {
        mobioRemoteNotification.registerForPushNotifications()
        let remoteNotificationViewModel = RemoteNotificationViewModel()
        mobioRemoteNotification.bindViewModel(to: remoteNotificationViewModel)
    }
}
