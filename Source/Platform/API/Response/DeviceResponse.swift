//
//  DeviceResponse.swift
//  MobioSDKSwift
//
//  Created by Sun on 04/04/2022.
//

import Foundation

struct DeviceResponse: Codable {
    let uID, dID, tID: String
    
    enum CodingKeys: String, CodingKey {
        case uID = "u_id"
        case dID = "d_id"
        case tID = "t_id"
    }
}
