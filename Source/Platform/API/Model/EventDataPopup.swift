//
//  EventDataPopup.swift
//  MobioSDKSwift
//
//  Created by Sun on 06/04/2022.
//

import Foundation

struct EventDataPopup {
    var key: String
    var name: String
    let fields: [Field]
}

extension EventDataPopup: Decodable { }
