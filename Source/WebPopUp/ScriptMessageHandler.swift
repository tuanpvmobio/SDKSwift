//
//  ScriptMessageHandler.swift
//  MobioSDKSwift
//
//  Created by Sun on 01/04/2022.
//

import WebKit

protocol ScriptMessageHandlerDelegate {
    func pass(data: MobioSDK.Dictionary)
}

class ScriptMessageHandler: NSObject, WKScriptMessageHandler {
    
    var delegate: ScriptMessageHandlerDelegate?
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if let dict = message.body as? MobioSDK.Dictionary {
            delegate?.pass(data: dict)
        }
    }
}
