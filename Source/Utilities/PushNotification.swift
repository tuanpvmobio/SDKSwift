//
//  PushNotification.swift
//  AppDemo
//
//  Created by LinhNobi on 29/09/2021.
//

import Foundation

struct PushNotification {
    
    static let deviceRepository = DeviceRepository(api: HTTPClient.shared)
    
    static func setDeviceToken(deviceToken: String) {
        UserDefaultManager.set(value: deviceToken, forKey: "PushNotificationDeviceToken")
        let notificationInfo = NotificationInfo(permission: "granted", token: deviceToken)
        deviceRepository.sendDeviceData(notificationInfo: notificationInfo)
        UserDefaults.standard.synchronize()
    }
    
    static func getDeviceToken() -> String {
        let deviceToken = UserDefaultManager.getString(forKey: "PushNotificationDeviceToken") 
        return deviceToken
    }
}

extension MobioSDK {
    public func setDeviceToken(deviceToken: String) {
        PushNotification.setDeviceToken(deviceToken: deviceToken)
    }
}
