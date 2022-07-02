//
//  URLSession+.swift
//  MobioSDKSwift
//
//  Created by Sun on 24/02/2022.
//

import Foundation

extension URLSession {
    
    static func configured() -> URLSession {
        let configuration = URLSessionConfiguration.ephemeral
        
        let token = UserDefaultManager.getString(forKey: "m_token")
        let merchantID = UserDefaultManager.getString(forKey: "m_merchant_id")
        
        configuration.timeoutIntervalForRequest = 5
        configuration.timeoutIntervalForResource = 5
        configuration.allowsCellularAccess = true
        configuration.httpAdditionalHeaders = [
            "Content-Type": "application/json; charset=utf-8",
            "Authorization": "Basic \(token)",
            "X-Merchant-Id": merchantID,
            "User-Agent": "analytics-ios \(MobioSDK.Constant.version)"
        ]
        let session = URLSession.init(configuration: configuration, delegate: nil, delegateQueue: nil)
        return session
    }
}
