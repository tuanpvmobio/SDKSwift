//
//  iOSLifecycleEventsNavigator.swift
//  MobioSDKSwift
//
//  Created by Sun on 12/04/2022.
//

import Foundation

struct iOSLifecycleEventsNavigator {
    
}

extension iOSLifecycleEventsNavigator: Navigationable {
    func showHTMLPopup(urlString: String) {
        let webPopupNavigator = WebPopupNavigator()
        let webPopupUseCase = WebPopupUseCase()
        let viewModel = WebPopupViewModel(urlString: urlString,
                                          navigator: webPopupNavigator,
                                          useCase: webPopupUseCase)
        let webviewController = WebPopupViewController()
        webviewController.bindViewModel(webPopupViewModel: viewModel)
        webviewController.modalPresentationStyle = .overFullScreen
        navigationController?.present(webviewController, animated: true, completion: nil)
    }
}
