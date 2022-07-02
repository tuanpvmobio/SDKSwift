//
//  PopupData.swift
//  MobioSDKSwift
//
//  Created by Sun on 04/04/2022.
//

import Foundation

struct PopupData {
    let popupType, popupID: String
    let popupURL: String
    let merchantID, masterCampaignID: String
    let profileInfo: MobioSDK.Dictionary
    let profileID, journeyID, nodeID, sendID: String
    let code, instanceID, webTarget: String

    enum CodingKeys: String, CodingKey {
        case popupType = "popup_type"
        case popupID = "popup_id"
        case popupURL = "popup_url"
        case merchantID = "merchant_id"
        case masterCampaignID = "master_campaign_id"
        case profileInfo = "profile_info"
        case profileID = "profile_id"
        case journeyID = "journey_id"
        case nodeID = "node_id"
        case sendID = "send_id"
        case code
        case instanceID = "instance_id"
        case webTarget = "web_target"
    }
}

extension PopupData: Decodable {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        profileInfo = try container.decode(MobioSDK.Dictionary.self, forKey: .profileInfo)
        popupType = try container.decode(String.self, forKey: .popupType)
        popupID = try container.decode(String.self, forKey: .popupID)
        popupURL = try container.decode(String.self, forKey: .popupURL)
        merchantID = try container.decode(String.self, forKey: .merchantID)
        masterCampaignID = try container.decode(String.self, forKey: .masterCampaignID)
        profileID = try container.decode(String.self, forKey: .profileID)
        journeyID = try container.decode(String.self, forKey: .journeyID)
        nodeID = try container.decode(String.self, forKey: .nodeID)
        sendID = try container.decode(String.self, forKey: .sendID)
        code = try container.decode(String.self, forKey: .code)
        instanceID = try container.decode(String.self, forKey: .instanceID)
        webTarget = try container.decode(String.self, forKey: .webTarget)
    }
}

extension PopupData: Encodable {
    
    func encode(to encoder: Encoder) throws {
    }
}
