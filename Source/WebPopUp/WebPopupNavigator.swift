//
//  WebPopupNavigator.swift
//  MobioSDKSwift
//
//  Created by Sun on 02/04/2022.
//

import Foundation

protocol WebPopupNavigatorType {
    func dismiss()
}

struct WebPopupNavigator: WebPopupNavigatorType {
    
    func dismiss() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
}

extension WebPopupNavigator: Navigationable { }
