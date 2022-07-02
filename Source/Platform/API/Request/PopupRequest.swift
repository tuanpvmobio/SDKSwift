//
//  PopupRequest.swift
//  MobioSDKSwift
//
//  Created by Sun on 04/04/2022.
//

import Foundation

class PopupRequest: ServiceBaseRequest {
    
    required init() {
        
        super.init(urlString: "", event: "DeviceRegister", params: [String : Any]())
    }
}
