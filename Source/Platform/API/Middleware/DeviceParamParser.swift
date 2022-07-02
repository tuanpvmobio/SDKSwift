//
//  DeviceParamParser.swift
//  MobioSDKSwift
//
//  Created by Sun on 01/04/2022.
//

import Foundation

struct DeviceParamParser {
    
    static func createSDK() -> SDK {
        return SDK()
    }
    
    static func createIdentityDetail(notificationInfo: NotificationInfo) -> IdentityDetail {
        return IdentityDetail(notificationInfo: notificationInfo)
    }
    
    static func createParam(notificationInfo: NotificationInfo) -> MobioSDK.Dictionary {
        let sdk = createSDK()
        let identityDetail = createIdentityDetail(notificationInfo: notificationInfo)
        let identity = Identity(sdk: sdk, identityDetail: identityDetail)
        if let encodeResult = try? identity.asDictionary() {
            return ["identity": encodeResult]
        } else {
            return Dictionary()
        }
    }
}
