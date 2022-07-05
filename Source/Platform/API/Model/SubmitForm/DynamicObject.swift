//
//  DynamicObject.swift
//  MobioSDKSwift
//
//  Created by Sun on 27/04/2022.
//

import Foundation

struct DynamicObject: Codable {
    let eventKey: String
    let eventData = DynamicEventData()

    enum CodingKeys: String, CodingKey {
        case eventKey = "event_key"
        case eventData = "event_data"
    }
}
