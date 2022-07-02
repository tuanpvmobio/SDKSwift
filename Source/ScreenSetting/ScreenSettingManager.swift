//
//  ScreenSettingManager.swift
//  MobioSDKSwift
//
//  Created by Sun on 26/02/2022.
//

import Foundation

protocol ScreenSettingGetable {
    func getConfigScreen() -> Set<ScreenSetting>
}

protocol ScreenSettingSetable {
    func screenSetting(title: String, controllerName: String, timeVisit: Array<Int>)
}

struct ScreenSettingManager {
    
    struct Constant {
        static let screenSettingKey = "m_screen_setting"
    }
    
    func addConfigScreen(_ screens: ScreenSetting) {
        var configScreen = getConfigScreen()
        configScreen.insert(ScreenSetting(title: screens.title, controllerName: screens.controllerName, timeVisit: screens.timeVisit))
        let data = configScreen.map { try? JSONEncoder().encode($0) }
        UserDefaultManager.set(value: data, forKey: Constant.screenSettingKey)
        UserDefaults.standard.synchronize()
    }
}

extension ScreenSettingManager: ScreenSettingGetable {
    
    
    func getConfigScreen() -> Set<ScreenSetting> {
        guard let encodedData = UserDefaults.standard.array(forKey: Constant.screenSettingKey) as? [Data] else {
            return []
        }
        let screenSettingArray = encodedData.compactMap {
            JSONManager.decode(ScreenSetting.self, from: $0)
        }
        return Set(screenSettingArray)
    }
}

extension ScreenSettingManager: ScreenSettingSetable {
    
    func screenSetting(title: String, controllerName: String, timeVisit: Array<Int>) {
        addConfigScreen(ScreenSetting(title: title, controllerName: controllerName, timeVisit: timeVisit))
    }
}

extension MobioSDK: ScreenSettingGetable {
    
    func getConfigScreen() -> Set<ScreenSetting> {
        screenSettingManager.getConfigScreen()
    }
}

extension MobioSDK: ScreenSettingSetable {
    
    public func screenSetting(title: String, controllerName: String, timeVisit: Array<Int>) {
        screenSettingManager.screenSetting(title: title, controllerName: controllerName, timeVisit: timeVisit)
    }
}
