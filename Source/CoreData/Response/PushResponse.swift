//
//  PushResponse.swift
//  MobioSDKSwift
//
//  Created by Sun on 11/01/2022.
//

import Foundation

struct PushResponse: Decodable {
    let pushes: [Push]
}
