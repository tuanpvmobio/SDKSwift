//
//  EventTracking.swift
//  MobioSDKSwift
//
//  Created by Sun on 28/03/2022.
//

import Foundation

struct EventTracking {
    
    var source = "popup_builder"
    var actionTime = 123456789
    var type: String
    var base: Base?
    var dynamic: [Dynamic]?
    
    init(type: String) {
        self.type = type
    }
    
    init(type: String, base: Base?) {
        self.init(type: type)
        self.base = base
    }
    
    init(type: String, dynamic: [Dynamic]) {
        self.init(type: type)
        self.dynamic = dynamic
    }
    
    init(type: String, eventPopup: EventPopup) {
        let actionTime = eventPopup.eventData.fields[0].value
        self.actionTime = actionTime
        let eventData = EventDataTracking(actionTime: actionTime)
        self.dynamic = [Dynamic(eventKey: eventPopup.eventKey, enventData: eventData, includedReport: eventPopup.includedReport)]
        self.type = type
    }
    
    enum CodingKeys: String, CodingKey {
        case source = "source"
        case type = "type"
        case actionTime = "action_time"
        case base = "base"
        case dynamic = "dynamic"
    }
}

extension EventTracking: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(source, forKey: .source)
        try container.encode(type, forKey: .type)
        try container.encode(actionTime, forKey: .actionTime)
        try container.encodeIfPresent(base, forKey: .base)
        try container.encodeIfPresent(dynamic, forKey: .dynamic)
    }
}

extension EventTracking: Decodable {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        source = try container.decode(String.self, forKey: .source)
        actionTime = try container.decode(Int.self, forKey: .actionTime)
        type = try container.decode(String.self, forKey: .type)
        base = try container.decode(Base.self, forKey: .base)
        dynamic = try container.decode([Dynamic].self, forKey: .dynamic)
    }
}
