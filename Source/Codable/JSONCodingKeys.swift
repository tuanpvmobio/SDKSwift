//
//  JSONCodingKeys.swift
//  MobioSDKSwift
//
//  Created by Cuong on 1/22/22.
//

import Foundation

struct JSONCodingKeys: CodingKey {
    var stringValue: String
    
    init?(stringValue: String) {
        self.stringValue = stringValue
    }
    
    var intValue: Int?
    
    init?(intValue: Int) {
        self.init(stringValue: "\(intValue)")
        self.intValue = intValue
    }
}
