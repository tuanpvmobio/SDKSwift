//
//  iOSLifecycleEventsViewModel.swift
//  MobioSDKSwift
//
//  Created by Sun on 12/04/2022.
//

import Foundation

struct iOSLifecycleEventsViewModel {
    
    var versionKey = "MobioVersionKey"
    var buildKey = "MobioBuildKeyV2"
    let trackingRepository = TrackingRepository(api: HTTPClient.shared)
    let iosLifecycleEventsNavigator = iOSLifecycleEventsNavigator()
    
    func didFinishLaunching() {
        _ = UserDefaultManager.getString(forKey: versionKey)
        let previousBuild = UserDefaultManager.getString(forKey: buildKey)
        let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        let currentBuild = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
        let isUserOpenApp = UserDefaultManager.getBool(forKey: "appOpenFirts")
        
        if (!isUserOpenApp) {
            print("Application Open First \(isUserOpenApp)")
            let properties: MobioSDK.Dictionary = [
                "version": currentVersion ?? "",
                "build": currentBuild ?? "",
            ]
            trackingRepository.getTrackingData(event: "sdk_mobile_test_open_first_app", properties: [properties])
            UserDefaultManager.set(value: true, forKey: "appOpenFirts")
            UserDefaults.standard.synchronize()
        }
        
        if previousBuild != "" {
            print("Application Installed")
            let properties = [
                "version": currentVersion ?? "",
                "build": currentBuild ?? "",
            ]
            trackingRepository.getTrackingData(event: "sdk_mobile_test_installed_app", properties: [properties])
        }
        
        if currentBuild != previousBuild {
            print("Application Updated")
            let properties = [
                "version": currentVersion ?? "",
                "build": currentBuild ?? "",
            ]
            trackingRepository.getTrackingData(event: "sdk_mobile_test_installed_app", properties: [properties])
        }
        
        // Application Opened
        print("Application Open")
        let properties = [
            "version": currentVersion ?? "",
            "build": currentBuild ?? "",
        ]
        trackingRepository.getTrackingData(event: "sdk_mobile_test_installed_app", properties: [properties])
        UserDefaultManager.set(value: currentVersion ?? "", forKey: versionKey)
        UserDefaultManager.set(value: currentBuild ?? "", forKey: buildKey)
    }
}
