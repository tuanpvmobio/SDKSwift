//
//  WebPopupManager.swift
//  MobioSDKSwift
//
//  Created by sun on 22/05/2022.
//

import UIKit

struct WebPopupManager: Navigationable {
    
    func showPopup(remoteNotificationData: RemoteNotificationData) {
        let webPopupNavigator = WebPopupNavigator()
        let webPopupUseCase = WebPopupUseCase()
        let viewModel = WebPopupViewModel(remoteNotificationData: remoteNotificationData,
                                          navigator: webPopupNavigator,
                                          useCase: webPopupUseCase)
        viewModel.showData()
    }
}
