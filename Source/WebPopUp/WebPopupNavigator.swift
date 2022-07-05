//
//  WebPopupNavigator.swift
//  MobioSDKSwift
//
//  Created by Sun on 02/04/2022.
//

import UIKit
import WebKit

protocol WebPopupNavigatorType {
    func dismiss()
    func redirect(urlString: String?)
    func presentPopup(webview: WKWebView, webPopupType: WebPopupType)
}

struct WebPopupNavigator: WebPopupNavigatorType {
    
    let webPopupViewController = WebPopupViewController.instantiate()
    
    func dismiss() {
        webPopupViewController.view.removeFromSuperview()
    }
    
    func redirect(urlString: String?) {
        topViewController?.dismiss(animated: false) {
            let safariScreen = SafariViewController.instantiate()
            safariScreen.modalPresentationStyle = .fullScreen
            safariScreen.urlString = urlString
            topViewController?.present(safariScreen, animated: true, completion: nil)
        }
    }
    
    func presentPopup(webview: WKWebView, webPopupType: WebPopupType) {
        webPopupViewController.modalPresentationStyle = .custom
        switch webPopupType {
        case .url(let popupData, let actionData):
            if popupData.popupPosition == "cc" {
                webPopupViewController.webviewHeight = Screen.height
            } else {
                webPopupViewController.webviewHeight = CGFloat(actionData.size?.heightMobile ?? Int(Screen.height))
            }
        case .html:
            webPopupViewController.webviewHeight = Screen.height
        }
        webPopupViewController.webview = webview
        webPopupViewController.view.frame = webPopupType.frame
        topViewController?.view.addSubview(webPopupViewController.view)
    }
}

extension WebPopupNavigator: Navigationable { }
