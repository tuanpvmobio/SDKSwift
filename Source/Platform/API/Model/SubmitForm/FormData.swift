//
//  FormData.swift
//  MobioSDKSwift
//
//  Created by Sun on 27/04/2022.
//

import Foundation

struct FormData: Codable {
    let id: String
    let fields: MobioSDK.Dictionary
    
    enum CodingKeys: String, CodingKey {
        case id
        case fields
    }
}

extension FormData {
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(fields, forKey: .fields)
    }
}

extension FormData {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        fields = try container.decode(MobioSDK.Dictionary.self, forKey: .fields)
    }
}
