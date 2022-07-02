//
//  DeviceRepository.swift
//  MobioSDKSwift
//
//  Created by Sun on 31/03/2022.
//

import Foundation

protocol DeviceRepositoryType {
    func sendDeviceData(notificationInfo: NotificationInfo) 
}

final class DeviceRepository: ServiceBaseRepository {
}

extension DeviceRepository: DeviceRepositoryType {
    
    func sendDeviceData(notificationInfo: NotificationInfo) {
        guard let api = api else { return }
        let input = DeviceRequest(notificationInfo: notificationInfo)
        api.request(input: input) { (object: DeviceResponse?, error) in
            if let object = object {
                print(object.tID)
            }
        }
    }
}
