//
//  IdentityDetail.swift
//  MobioSDKSwift
//
//  Created by Sun on 01/04/2022.
//

import Foundation

struct IdentityDetail: Codable {
    
    let type = "mobile"
    let channel = "app"
    let name = "apple"
    let networkAddress = "127.0.0.1"
    let dID = ""
    let tID = "huyhl-123-456-789"
    let uID = ""
    let notificationInfo: NotificationInfo
    
    init(notificationInfo: NotificationInfo) {
        self.notificationInfo = notificationInfo
    }
    
    enum CodingKeys: String, CodingKey {
        case type, channel, name
        case networkAddress = "network_address"
        case dID = "d_id"
        case tID = "t_id"
        case uID = "u_id"
        case notificationInfo = "notification"
    }
}
