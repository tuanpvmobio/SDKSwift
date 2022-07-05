//
//  NotificationParser.swift
//  MobioSDKSwift
//
//  Created by sun on 21/04/2022.
//

import Foundation

struct NotificationParser {
    
    static var analytics = MobioSDK.shared
    
    static func createSDK() -> SDK {
        return analytics.sdk
    }
    
    static func createNotificationDevice() -> NotificationDevice {
        return NotificationDevice()
    }
    
    static func createNotificationDetail(permission: String, token: String?) -> NotificationDetail {
        return NotificationDetail(permission: permission, token: token)
    }
    
    static func createParam(permission: String, token: String?) -> MobioSDK.Dictionary {
        let sdk = createSDK()
        let device = createNotificationDevice()
        let detail = createNotificationDetail(permission: permission, token: token)
        let notificationData = NotificationData(sdk: sdk, device: device, detail: detail)
        if let encodeResult = try? notificationData.asDictionary() {
            DictionaryPrinter.printBeauty(with: encodeResult)
            return ["notification": encodeResult]
        } else {
            return Dictionary()
        }
    }
}
