//
//  WebPopupStatusManager.swift
//  MobioSDKSwift
//
//  Created by Sun on 28/04/2022.
//

import Foundation

struct WebPopupStatusManager {
    
    static let popupBuilderStatusRepository = PopupBuilderStatusRepository(api: HTTPClient.shared)
    
    static func pushDataStatusPopup(popupData: PopupData, statusCase: WebStatusCase) {
        popupBuilderStatusRepository.sendPopupBuilderStatus(popupData: popupData, statusCase: statusCase)
    }
}
