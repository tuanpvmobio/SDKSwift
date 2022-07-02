//
//  RecallApiRequest.swift
//  MobioSDKSwift
//
//  Created by Sun on 05/04/2022.
//

import Foundation

class RecallApiRequest: ServiceBaseRequest {
    
    init(failAPI: FailAPI) {
        super.init(urlString: failAPI.urlString, event: failAPI.event, params: failAPI.params)
    }
}
