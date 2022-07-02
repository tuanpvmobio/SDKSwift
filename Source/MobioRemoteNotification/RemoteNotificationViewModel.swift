//
//  RemoteNotificationViewModel.swift
//  MobioSDKSwift
//
//  Created by Sun on 25/03/2022.
//

import Foundation

class RemoteNotificationViewModel {
    
    let trackingManager = TrackingManager()
    let deviceRepository = DeviceRepository(api: HTTPClient.shared)
    
    func trackEnableNotification(enable: String) {
        let properties = ["enable": enable]
        track(name: "sdk_mobile_test_enable_notification", properties: [properties])
    }
    
    func sendDeviceData(notificationInfo: NotificationInfo) {
        deviceRepository.sendDeviceData(notificationInfo: notificationInfo)
    }
}

extension RemoteNotificationViewModel: Navigationable {
    func showHTMLPopup(urlString: String) {
        let webPopupNavigator = WebPopupNavigator()
        let webPopupUseCase = WebPopupUseCase()
        let viewModel = WebPopupViewModel(urlString: urlString,
                                          navigator: webPopupNavigator,
                                          useCase: webPopupUseCase)
        let webviewController = WebPopupViewController()
        print("------ debug ------- iOSLifecycleEventsNavigator")
        webviewController.bindViewModel(webPopupViewModel: viewModel)
        webviewController.modalPresentationStyle = .overFullScreen
        navigationController?.present(webviewController, animated: true, completion: nil)
    }
}

extension RemoteNotificationViewModel: Trackable {
    func track(name: String, properties: [MobioSDK.Dictionary]) {
        trackingManager.track(name: name, properties: properties)
    }
}
