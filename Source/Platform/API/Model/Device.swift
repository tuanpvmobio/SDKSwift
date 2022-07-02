//
//  Device.swift
//  MobioSDKSwift
//
//  Created by Sun on 28/03/2022.
//

import Foundation

import Foundation

struct Device {
    var type = "mobile"
    var channel = "app"
    var dId = ""
    var tId = "abc123"
    var uId = ""
    
    enum CodingKeys: String, CodingKey {
        case type = "type"
        case channel = "channel"
        case dId = "d_id"
        case tId = "t_id"
        case uId = "u_id"
    }
}

extension Device: Encodable {
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(channel, forKey: .channel)
        try container.encode(dId, forKey: .dId)
        try container.encode(tId, forKey: .tId)
        try container.encode(uId, forKey: .uId)
    }
}
