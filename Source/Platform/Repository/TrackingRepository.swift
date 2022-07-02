//
//  TrackingRepository.swift
//  MobioSDKSwift
//
//  Created by Sun on 23/02/2022.
//

import Foundation

protocol TrackingRepositoryType {
    func getTrackingData(event: String, properties: [MobioSDK.Dictionary])
}

final class TrackingRepository: ServiceBaseRepository {
}

extension TrackingRepository: TrackingRepositoryType {
    
    func getTrackingData(event: String, properties: [MobioSDK.Dictionary]) {
        guard let api = api else { return }
        let input = TrackingRequest(event: event, properties: properties)
        api.request(input: input) { (object: TrackingResponse?, error) in
            if let object = object {
                print(object)
            }
        }
    }
}
