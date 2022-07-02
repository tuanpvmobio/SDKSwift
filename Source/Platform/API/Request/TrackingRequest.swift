//
//  TrackingRequest.swift
//  MobioSDKSwift
//
//  Created by Sun on 23/02/2022.
//

import UIKit

class TrackingRequest: ServiceBaseRequest {
    
    required convenience init(event: String, properties: [MobioSDK.Dictionary]) {
        let params = TrackingParamParser.createParam(event: event, properties: properties)
        self.init(urlString: URLs.trackUrl, event: event, params: params)
    }
}
