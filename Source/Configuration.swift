//
//  Configuration.swift
//  AppDemo
//
//  Created by LinhNobi on 30/09/2021.
//

import Foundation

public class Configuration {

    var merchantID: String = ""
    var token: String = ""

    public init(merchantID: String) {
        self.merchantID = merchantID
    }
}

public extension Configuration {
    @discardableResult
    func token(_ value: String) -> Configuration {
        token = value
        return self
    }
}
