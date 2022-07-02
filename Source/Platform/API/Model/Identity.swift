//
//  Identity.swift
//  MobioSDKSwift
//
//  Created by Sun on 01/04/2022.
//

import Foundation

struct Identity: Encodable {
    
    let sdk: SDK
    let identityDetail: IdentityDetail

    enum CodingKeys: String, CodingKey {
        case sdk
        case identityDetail = "identity_detail"
    }
}
