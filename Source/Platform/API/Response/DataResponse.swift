//
//  DataResponse.swift
//  MobioSDKSwift
//
//  Created by Sun on 29/04/2022.
//

import Foundation

struct DataResponse: Codable {
    let uID, dID, tID: String
    let actionTime: Int

    enum CodingKeys: String, CodingKey {
        case uID = "u_id"
        case dID = "d_id"
        case tID = "t_id"
        case actionTime = "action_time"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        uID = try container.decode(String.self, forKey: .uID)
        dID = try container.decode(String.self, forKey: .dID)
        tID = try container.decode(String.self, forKey: .tID)
        actionTime = try container.decode(Int.self, forKey: .actionTime)
        saveDID()
    }
    
    func saveDID() {
        UserDefaultManager.set(value: dID, forKey: .dID)
    }
}
