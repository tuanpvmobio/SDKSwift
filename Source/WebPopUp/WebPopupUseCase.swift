//
//  WebPopupUseCase.swift
//  MobioSDKSwift
//
//  Created by Sun on 06/04/2022.
//

import Foundation

protocol WebPopupUseCaseType {
    func pushDataPopup(events: [MobioSDK.Dictionary])
}

struct WebPopupUseCase {
    let trackingRepository = TrackingRepository(api: HTTPClient.shared)
}

extension WebPopupUseCase: WebPopupUseCaseType {
    
    func pushDataPopup(events: [MobioSDK.Dictionary]) {
        trackingRepository.getTrackingData(event: "Popup To Web", properties: events)
    }
}
