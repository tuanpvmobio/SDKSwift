//
//  ServiceBaseRequest.swift
//  MobioSDKSwift
//
//  Created by Sun on 23/02/2022.
//

import UIKit

class ServiceBaseRequest {
    
    var urlString = ""
    var event = ""
    var params = [String: Any]()
    
    init(urlString: String, event: String, params: [String: Any]) {
        self.urlString = urlString
        self.event = event
        self.params = params
    }
}
