//
//  TrackingManager.swift
//  MobioSDKSwift
//
//  Created by Sun on 25/02/2022.
//

import Foundation

protocol Trackable {
    func track(name: String, properties: [MobioSDK.Dictionary])
}

protocol Identifyable {
    func identify(name: String, properties: [MobioSDK.Dictionary])
}

class TrackingManager {
    
    let trackRepository = TrackingRepository(api: HTTPClient.shared)
}

extension TrackingManager: Trackable, Identifyable {
    
    func track(name: String, properties: [MobioSDK.Dictionary]) {
        trackRepository.getTrackingData(event: name, properties: properties)
    }
    
    func identify(name: String, properties: [MobioSDK.Dictionary]) {
        trackRepository.getTrackingData(event: name, properties: properties)
    }
}

extension MobioSDK: Trackable, Identifyable {
    
    public func track(name: String, properties: [MobioSDK.Dictionary]) {
        trackingManager.track(name: name, properties: properties)
    }
    
    public func identify(name: String, properties: [MobioSDK.Dictionary]) {
        trackingManager.track(name: name, properties: properties)
    }
}
