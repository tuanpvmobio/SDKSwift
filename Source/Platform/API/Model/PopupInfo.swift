//
//  PopupInfo.swift
//  MobioSDKSwift
//
//  Created by Sun on 04/04/2022.
//

import Foundation

struct PopupInfo: Codable {
    let messageID, title, body, image: String
    let icon, urlTarget, pushType: String
    let data: PopupData

    enum CodingKeys: String, CodingKey {
        case messageID = "message_id"
        case title, body, image, icon
        case urlTarget = "url_target"
        case pushType = "push_type"
        case data
    }
}
