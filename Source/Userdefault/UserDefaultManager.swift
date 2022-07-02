//
//  UserDefaultManager.swift
//  MobioSDKSwift
//
//  Created by Sun on 22/02/2022.
//

import Foundation

struct UserDefaultManager {
    
    static private let userDefault = UserDefaults.standard
    
    static func set(value: Any, forKey: String) {
        userDefault.set(value, forKey: forKey)
    }
    
    static func getString(forKey: String) -> String {
        if let value = userDefault.object(forKey: forKey) as? String {
            return value
        } else {
            return ""
        }
    }
    
    static func getInt(forKey: String) -> Int {
        if let value = userDefault.object(forKey: forKey) as? Int {
            return value
        } else {
            return 0
        }
    }
    
    static func getBool(forKey: String) -> Bool {
        if let value = userDefault.object(forKey: forKey) as? Bool {
            return value
        } else {
            return false
        }
    }
}
