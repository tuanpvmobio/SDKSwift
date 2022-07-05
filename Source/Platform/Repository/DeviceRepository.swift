//
//  DeviceRepository.swift
//  MobioSDKSwift
//
//  Created by Sun on 31/03/2022.
//

import Foundation

protocol DeviceRepositoryType {
    func sendDeviceData()
    func saveDID(_ dID: String)
}

final class DeviceRepository: ServiceBaseRepository {
}

extension DeviceRepository: DeviceRepositoryType {
    
    func saveDID(_ dID: String) {
        UserDefaultManager.set(value: dID, forKey: .dID)
    }
    
    func sendDeviceData() {
        guard let api = api else { return }
        let input = DeviceRequest()
        api.request(input: input) { (object: DeviceResponse?, error) in
        }
    }
}
