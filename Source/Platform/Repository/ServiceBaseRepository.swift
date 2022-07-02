//
//  ServiceBaseRepository.swift
//  MobioSDKSwift
//
//  Created by Sun on 24/02/2022.
//

import Foundation

class ServiceBaseRepository {
    
    var api: HTTPClient!
    
    init(api: HTTPClient) {
        self.api = api
    }
}
