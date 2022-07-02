//
//  DictionaryPrinter.swift
//  MobioSDKSwift
//
//  Created by Sun on 31/03/2022.
//

import Foundation

struct DictionaryPrinter {
    
    static func printBeauty(with dictionary: MobioSDK.Dictionary) {
        if let data = try? JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted),
           let dataString = String(data: data, encoding: .utf8) {
            print(dataString)
        } else {
            print("Wrong param")
        }
    }
}
