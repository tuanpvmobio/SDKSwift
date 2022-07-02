//
//  Track.swift
//  MobioSDKSwift
//
//  Created by Sun on 28/03/2022.
//

import Foundation

public struct Track {
    var sdk = SDK()
    var device = Device()
    var events: [EventTracking]
    
    enum CodingKeys: String, CodingKey {
        case sdk = "sdk"
        case device = "device"
        case events = "events"
    }
}

extension Track: Encodable {
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(sdk, forKey: .sdk)
        try container.encode(device, forKey: .device)
        try container.encode(events, forKey: .events)
    }
}
