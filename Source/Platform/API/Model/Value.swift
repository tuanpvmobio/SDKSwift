//
//  Value.swift
//  MobioSDKSwift
//
//  Created by Sun on 28/03/2022.
//

import Foundation

struct Value {
    var id = "this is id"
    var inputFields = [InputField]()
    var button = Button()
    var journey = Journey()
}

extension Value: Encodable {
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case inputFields = "input_fields"
        case button = "button"
        case journey = "journey"
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(inputFields, forKey: .inputFields)
        try container.encode(button, forKey: .button)
        try container.encode(journey, forKey: .journey)
    }
}
