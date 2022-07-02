//
//  DeviceRequest.swift
//  MobioSDKSwift
//
//  Created by Sun on 01/04/2022.
//

import Foundation

class DeviceRequest: ServiceBaseRequest {
    
    required init(notificationInfo: NotificationInfo) {
        let params = DeviceParamParser.createParam(notificationInfo: notificationInfo)
        super.init(urlString: URLs.deviceUrl, event: "DeviceRegister", params: params)
    }
}
