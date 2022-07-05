//
//  iOSLifecycleEventsViewModel.swift
//  MobioSDKSwift
//
//  Created by Sun on 12/04/2022.
//

import Foundation

struct iOSLifecycleEventsViewModel {
    
    let trackingRepository = TrackingRepository(api: HTTPClient.shared)
    let iosLifecycleEventsNavigator = iOSLifecycleEventsNavigator()
    let deviceRepository = DeviceRepository(api: HTTPClient.shared)
    let notificationRepository = NotificationRepository(api: HTTPClient.shared)

    func didFinishLaunching() {
        _ = UserDefaultManager.getString(forKey: .versionKey)
        let previousBuild = UserDefaultManager.getString(forKey: .buildKey)
        let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        let currentBuild = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
        let isUserOpenApp = UserDefaultManager.getBool(forKey: .appOpenFirts)
        
        if (!isUserOpenApp) {
            let properties: MobioSDK.Dictionary = [
                "version": currentVersion ?? "",
                "build": currentBuild ?? "",
            ]
            trackingRepository.getTrackingData(event: "sdk_mobile_test_open_first_app", properties: properties)
            UserDefaultManager.set(value: true, forKey: .appOpenFirts)
            UserDefaults.standard.synchronize()
        }
        
        if previousBuild != "" {
            let properties = [
                "version": currentVersion ?? "",
                "build": currentBuild ?? "",
            ]
            trackingRepository.getTrackingData(event: "sdk_mobile_test_installed_app", properties: properties)
        }
        
        if currentBuild != previousBuild {
            let properties = [
                "version": currentVersion ?? "",
                "build": currentBuild ?? "",
            ]
            trackingRepository.getTrackingData(event: "sdk_mobile_test_installed_app", properties: properties)
        }
        
        // Application Opened
        let properties = [
            "version": currentVersion ?? "",
            "build": currentBuild ?? "",
        ]
        trackingRepository.getTrackingData(event: "sdk_mobile_test_installed_app", properties: properties)
        UserDefaultManager.set(value: currentVersion ?? "", forKey: .versionKey)
        UserDefaultManager.set(value: currentBuild ?? "", forKey: .buildKey)
        deviceRepository.sendDeviceData()
        notificationRepository.sendNotificationData(permission: "denied", token: nil)
    }
}
