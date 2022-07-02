//
//  MobioSDK.swift
//  AppDemo
//
//  Created by LinhNobi on 25/08/2021.
//

import Foundation

open class MobioSDK {
    
    // MARK: - Define
    struct Constant {
        static let version = "1.0.0"
    }
    public typealias Dictionary = [String : Any]
    
    // MARK: - Property
    public static let shared = MobioSDK()
    var iOSlife = iOSLifecycleMonitor()
    let trackingManager = TrackingManager()
    let screenSettingManager = ScreenSettingManager()
    let mobioRemoteNotification = MobioRemoteNotification()
    let apiRecallManager = APIRecallManager.shared
    
    private init() {
        iOSlife.setupListeners()
        setupRemoteNotification()
    }
    
    public func bindConfiguration(configuration: Configuration) {
        UserDefaultManager.set(value: configuration.token, forKey: "m_token")
        UserDefaultManager.set(value: configuration.merchantID, forKey: "m_merchant_id")
        UserDefaults.standard.synchronize()
    }
    
    private func setupRemoteNotification() {
        mobioRemoteNotification.registerForPushNotifications()
        let remoteNotificationViewModel = RemoteNotificationViewModel()
        mobioRemoteNotification.bindViewModel(to: remoteNotificationViewModel)
    }
}
