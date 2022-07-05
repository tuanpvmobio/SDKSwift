//
//  DynamicEvent.swift
//  MobioSDKSwift
//
//  Created by Sun on 25/04/2022.
//

import Foundation

class DynamicEvent: EventShared {
    var dynamics: [DynamicObject]!
    
    init(dynamics: [DynamicObject], type: String, source: String, actionTime: Int) {
        super.init(type: type, source: source, actionTime: actionTime)
        self.dynamics = dynamics
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    enum CodingKeys: String, CodingKey {
        case dynamics
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(dynamics, forKey: .dynamics)
    }
}
