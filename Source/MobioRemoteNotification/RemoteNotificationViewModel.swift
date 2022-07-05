//
//  RemoteNotificationViewModel.swift
//  MobioSDKSwift
//
//  Created by Sun on 25/03/2022.
//

import UIKit

class RemoteNotificationViewModel {
    let webPopupManager = WebPopupManager()
}

extension RemoteNotificationViewModel {
    
    func decideShowPopup(remoteNotificationData: RemoteNotificationData) {
        switch remoteNotificationData.alert.contentType {
        case "text": break
        case "popup": webPopupManager.showPopup(remoteNotificationData: remoteNotificationData)
        case "html": webPopupManager.showPopup(remoteNotificationData: remoteNotificationData)
        default: break
        }
    }
}
