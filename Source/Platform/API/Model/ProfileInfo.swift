//
//  ProfileInfo.swift
//  MobioSDKSwift
//
//  Created by Sun on 04/04/2022.
//

import Foundation

struct ProfileInfo: Codable {
    let name, vcCode: String

    enum CodingKeys: String, CodingKey {
        case name = "NAME"
        case vcCode = "VC_CODE"
    }
}
