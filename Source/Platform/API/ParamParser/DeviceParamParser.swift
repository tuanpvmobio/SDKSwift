//
//  DeviceParamParser.swift
//  MobioSDKSwift
//
//  Created by Sun on 01/04/2022.
//

import Foundation

struct DeviceParamParser {
    
    static var analytics = MobioSDK.shared
    
    static func createSDK() -> SDK {
        return analytics.sdk
    }
    
    static func createDetail() -> Detail {
        return Detail()
    }
    
    static func createParam() -> MobioSDK.Dictionary {
        let sdk = createSDK()
        let detail = createDetail()
        let identity = Identity(sdk: sdk, device: detail)
        if let encodeResult = try? identity.asDictionary() {
            return ["identity": encodeResult]
        } else {
            return Dictionary()
        }
    }
}
