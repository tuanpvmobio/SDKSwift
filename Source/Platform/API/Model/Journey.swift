//
//  Journey.swift
//  MobioSDKSwift
//
//  Created by Sun on 28/03/2022.
//

import Foundation

struct Journey {
   var id = "this is id"
   var nodeId = "this is node id"
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case nodeId = "node_id"
    }
}

extension Journey: Encodable {
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(nodeId, forKey: .nodeId)
    }
}
