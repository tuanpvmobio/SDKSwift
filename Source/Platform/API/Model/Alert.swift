//
//  Alert.swift
//  MobioSDKSwift
//
//  Created by Sun on 15/04/2022.
//

import Foundation

struct Alert: Codable {
    let body: String?
    let urlTarget: String
    let title: String?
    let backgroundImage: String?
    let contentType: String

    enum CodingKeys: String, CodingKey {
        case body
        case urlTarget = "url_target"
        case title
        case backgroundImage = "background_image"
        case contentType = "content_type"
    }
}
