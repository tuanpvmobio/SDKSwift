//
//  MobioRemoteNotification.swift
//  ExampleNotification
//
//  Created by Sun on 02/11/2021.
//

import UserNotifications
import UIKit

protocol MobioRemoteNotificationType {
    
    // MARK: - function
    func registerForPushNotifications()
}

final class MobioRemoteNotification: NSObject {
    
    // MARK: - Property
    let center = UNUserNotificationCenter.current()
    var viewModel: RemoteNotificationViewModel!
}

extension MobioRemoteNotification: MobioRemoteNotificationType {
    
    func registerForPushNotifications() {
        center.delegate = self
        center.requestAuthorization(options: [.alert, .sound, .badge, .carPlay]) { [weak self] (granted, error) in
            guard let self = self else { return }
            self.getNotificationSettings()
        }
    }
    
    func getNotificationSettings() {
        center.getNotificationSettings { [weak self] settings in
            guard let self = self else { return }
            self.setupNotificationSetting(settings: settings)
        }
    }
    
    func setupNotificationSetting(settings: UNNotificationSettings) {
        var enable = "false"
        if settings.authorizationStatus == .authorized {
            print("------ debug ------ Remote notif = True")
            enable = "true"
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        } else {
            enable = "false"
            print("------ debug ------ Remote notif = No")
            let notificationInfo = NotificationInfo(permission: "denied")
            viewModel.sendDeviceData(notificationInfo: notificationInfo)
        }
        viewModel.trackEnableNotification(enable: enable)
    }
}

extension MobioRemoteNotification: BindableType { }

extension MobioRemoteNotification: UNUserNotificationCenterDelegate {
    
    public func userNotificationCenter(_ center: UNUserNotificationCenter,
                                       willPresent notification: UNNotification,
                                       withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let request = notification.request
        let content = request.content
        let body = content.body
        
        let state = UIApplication.shared.applicationState
        if state == .background || state == .inactive {
            print("------ debug 1-----: app from background")
            completionHandler([.badge, .alert, .sound])
        } else if state == .active {
            print("------ debug 1-----: app from active")
            let urlString = "https://test38.mobio.vn/624aa6e8365e1f7a2b81165c.html"
            viewModel.showHTMLPopup(urlString: urlString)
        }
    }
    
    public func userNotificationCenter(_ center: UNUserNotificationCenter,
                                       didReceive response: UNNotificationResponse,
                                       withCompletionHandler completionHandler: @escaping () -> Void) {
        let notification = response.notification
        let request = notification.request
        let content = request.content
        let body = content.body
        let state = UIApplication.shared.applicationState
        if state == .background || state == .inactive {
            print("------ debug 2-----: app from background")
            let urlString = "https://test38.mobio.vn/624aa6e8365e1f7a2b81165c.html"
            viewModel.showHTMLPopup(urlString: urlString)
        } else if state == .active {
            print("------ debug 2-----: app from active")
        }
        completionHandler()
    }
}
