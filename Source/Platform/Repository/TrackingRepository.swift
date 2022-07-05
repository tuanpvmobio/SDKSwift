//
//  TrackingRepository.swift
//  MobioSDKSwift
//
//  Created by Sun on 23/02/2022.
//

import Foundation

protocol TrackingRepositoryType {
    func getTrackingData(event: String, properties: MobioSDK.Dictionary, type: TrackType) 
}

final class TrackingRepository: ServiceBaseRepository {
}

extension TrackingRepository: TrackingRepositoryType {
    
    func getTrackingData(event: String, properties: MobioSDK.Dictionary, type: TrackType = .default) {
        guard let api = api else { return }
        let input = TrackingRequest(event: event, properties: properties, type: type.rawValue)
        api.request(input: input) { (object: TrackingResponse?, error) in
        }
    }
}
