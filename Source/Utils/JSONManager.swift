//
//  JSONManager.swift
//  MobioSDKSwift
//
//  Created by Sun on 20/02/2022.
//

import Foundation

struct JSONManager {
    
    private static let decoder = JSONDecoder()
    private static let encoder = JSONEncoder()
    
    static func decode<T: Decodable>(_ type: T.Type, from data: Data?) -> T? {
        guard let data = data else {
            return nil
        }
        let result = try? decoder.decode(type, from: data)
        return result
    }
    
    static func decode<T: Decodable>(_ type: T.Type, from dictionary: MobioSDK.Dictionary?) -> T? {
        guard let dictionary = dictionary else {
            return nil
        }
        let data = try? JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
        let result = Self.decode(type, from: data)
        return result
    }
    
    static func decode<T: Decodable>(_ type: T.Type, from jsonString: String) -> T? {
        let data = popupJson.data(using: .utf8)
        let result = Self.decode(type, from: data)
        return result
    }
}
