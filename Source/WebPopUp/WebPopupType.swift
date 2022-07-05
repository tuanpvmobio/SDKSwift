//
//  WebPopupType.swift
//  MobioSDKSwift
//
//  Created by Sun on 30/05/2022.
//

import UIKit


enum WebPopupType {
    case url(popupData: PopupData, actionData: PopupBuilderActionData)
    case html
    
    var frame: CGRect {
        switch self {
        case .url(let popupData, let actionData):
            if let size = actionData.size, let position = popupData.popupPosition, CGFloat(size.heightMobile) < Screen.height {
                return getWebFrame(webHeight: CGFloat(size.heightMobile), position: position)
            } else {
                return getWebFrame(webHeight: Screen.height)
            }
        case .html:
            return getWebFrame(webHeight: Screen.height)
        }
    }
    
    private func getWebFrame(webHeight: CGFloat, position: String = "cc") -> CGRect {
        if let transitionPosition = WebTransitionPosition(rawValue: position) {
            return transitionPosition.getFrame(height: webHeight)
        } else {
            return CGRect.zero
        }
    }
}
