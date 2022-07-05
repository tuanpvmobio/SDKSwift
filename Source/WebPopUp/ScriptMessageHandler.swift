//
//  ScriptMessageHandler.swift
//  MobioSDKSwift
//
//  Created by Sun on 01/04/2022.
//

import WebKit

protocol ScriptMessageHandlerDelegate {
    func pass(actionData: PopupBuilderActionData)
}

class ScriptMessageHandler: NSObject, WKScriptMessageHandler {
    
    var delegate: ScriptMessageHandlerDelegate?
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        DictionaryPrinter.printBeauty(with: message.body)
        if let actionDataPopup = JSONManager.decode(PopupBuilderActionData.self, from: message.body) {
            delegate?.pass(actionData: actionDataPopup)            
        }
    }
}
