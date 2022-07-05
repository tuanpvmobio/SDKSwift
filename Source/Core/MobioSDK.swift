//
//  MobioSDK.swift
//  AppDemo
//
//  Created by LinhNobi on 25/08/2021.
//

import Foundation
import UserNotifications

@objcMembers open class MobioSDK: NSObject {
    
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
    var apiRecallManager = APIRecallManager.shared
    let notificationRepository = NotificationRepository(api: HTTPClient.shared)
    let connectionManager = ConnectionManager.shared
    var sdk = SDK()
    
    public override init() {
        super.init()
        iOSlife.setupListeners()
        setupRemoteNotification()
        apiRecallManager.setupInternetManager()
    }
    
    public func bindConfiguration(configuration: Configuration) {
        UserDefaultManager.set(value: configuration.token, forKey: .token)
        UserDefaultManager.set(value: configuration.merchantID, forKey: .merchantID)
    }
    
    private func setupRemoteNotification() {
        mobioRemoteNotification.registerForPushNotifications()
        let remoteNotificationViewModel = RemoteNotificationViewModel()
        mobioRemoteNotification.bindViewModel(to: remoteNotificationViewModel)
    }
    
    public func send(deviceToken: String) {
        notificationRepository.sendNotificationData(permission: "granted", token: deviceToken)
    }
    
    public func deeplink(with viewController: String?) {
        guard let viewController = viewController else { return }
        let navigator = Navigator(screenNameArray: [viewController], type: .goto)
        navigator.navigationAction()
    }
    
    public func setupSDK(code: String, source: String) {
        sdk.code = code
        sdk.source = source
    }
}

extension MobioSDK: MobioRemoteNotificationType {
    public func registerForPushNotifications() {
        mobioRemoteNotification.registerForPushNotifications()
    }
    
    public func notificationWillPresent(with notification: UNNotification, completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        mobioRemoteNotification.notificationWillPresent(with: notification, completionHandler: completionHandler)
    }
    
    public func notificationDidReceive(with response: UNNotificationResponse) {
        mobioRemoteNotification.notificationDidReceive(with: response)
    }
}
