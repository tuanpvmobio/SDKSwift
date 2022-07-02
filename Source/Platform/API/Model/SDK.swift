//
//  SDK.swift
//  MobioSDKSwift
//
//  Created by Sun on 28/03/2022.
//

import Foundation

struct SDK {
    var code = "123456"
}

extension SDK: Encodable {
    
    enum CodingKeys: String, CodingKey {
        case code = "code"
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(code, forKey: .code)
    }
}
