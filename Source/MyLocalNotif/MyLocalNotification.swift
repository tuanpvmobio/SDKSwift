//
//  MyLocalNotification.swift
//  ExampleNotification
//
//  Created by Sun on 08/10/2021.
//

import UserNotifications
import UIKit

public protocol MyLocalNotificationType {
    func pushNotif(with content: NotificationContent, after second: TimeInterval)
    func pushNotif(with content: NotificationContent, component: DateComponents)
}

public class MyLocalNotification: NSObject {
    
    // MARK: - Property
    private var center: UNUserNotificationCenter {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        return center
    }
    lazy var notificationAction = NotificationAction(center: center)
    var popupManager = PopupManager.shared
    let pushRepository = PushRepository(manager: DBManager.shared)
    let trackingManager = TrackingManager()
    
    // MARK: - Init
    public override init() {
        super.init()
        setupData()
    }
    
    // MARK: - Setup Data
    private func setupData() {
        notificationAction.setupNotificationAction()
    }
    
    // MARK: - Create item
    private func createContent(_ myContent: NotificationContent) -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = myContent.title
        content.body = myContent.body
        content.categoryIdentifier = NotificationAction.Constant.categoryIdentifier
        content.userInfo = [NotificationContentUserInfo.pushData.rawValue: myContent.pushID]
        return content
    }
    
    private func createTrigger(with second: TimeInterval) -> UNNotificationTrigger {
        let date = Date().addingTimeInterval(second)
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        return trigger
    }
    
    private func createTrigger(dateComponents: DateComponents) -> UNNotificationTrigger {
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        return trigger
    }
    
    private func createRequest(content: NotificationContent, second: TimeInterval) -> UNNotificationRequest {
        let uuidString = UUID().uuidString
        
        // Step 2: Create the notification content
        let content = createContent(content)
        
        // Step 3: Create the notification trigger
        let trigger = createTrigger(with: second)
        
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        return request
    }
    
    private func createRequest(content: NotificationContent, component: DateComponents) -> UNNotificationRequest {
        let uuidString = UUID().uuidString
        
        // Step 2: Create the notification content
        let content = createContent(content)
        
        // Step 3: Create the notification trigger
        let trigger = createTrigger(dateComponents: component)
        
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        return request
    }
}

extension MyLocalNotification: MyLocalNotificationType {

    public func pushNotif(with content: NotificationContent, after second: TimeInterval) {
        print("-------- debug -------- notif content = \(content) ------ with time = \(second)")
        
        // Step 4: Create the request
        let request = createRequest(content: content, second: second)
        
        // Step 5: Register the request
        center.add(request) { (error) in
            // Check the error parameter and handle any errors
            print("-------- debug -------- notif error = ", error.debugDescription)
        }
    }
    
    public func pushNotif(with content: NotificationContent, component: DateComponents) {
        // Step 4: Create the request
        let request = createRequest(content: content, component: component)
        
        // Step 5: Register the request
        center.add(request) { (error) in
            // Check the error parameter and handle any errors
        }
    }
}

extension MyLocalNotification: UNUserNotificationCenterDelegate {
    
    public func userNotificationCenter(_ center: UNUserNotificationCenter,
                                       willPresent notification: UNNotification,
                                       withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let request = notification.request
        let content = request.content
        let title = content.title
        let state = UIApplication.shared.applicationState
        let properties = ["title": title]
        track(name: "notification_willpresent", properties: [properties])
        if state == .background || state == .inactive {
            print("------ debug 1-----: app from background ----- title = ", title)
            completionHandler([.badge, .alert, .sound])
        } else if state == .active {
            let userInfo = content.userInfo
            if let pushID = userInfo[NotificationContentUserInfo.pushData.rawValue] as? String {
                print("------ debug 1-----: app from active ----- title = ", pushID)
                pushIsNotShowed(pushID)
            }
            completionHandler([])
        }
    }
    
    public func userNotificationCenter(_ center: UNUserNotificationCenter,
                                       didReceive response: UNNotificationResponse,
                                       withCompletionHandler completionHandler: @escaping () -> Void) {
        notificationAction.handleNotificationAction(with: response)
        completionHandler()
    }
}

extension MyLocalNotification: PushRepositoryDelegate {
    
    func pushIsNotShowed(_ pushID: String) {
        pushRepository.pushIsNotShowed(pushID)
    }
    
    func pushIsShowed(_ pushID: String) {
        pushRepository.pushIsShowed(pushID)
    }
}

extension MyLocalNotification: Trackable {
    
    func track(name: String, properties: [MobioSDK.Dictionary]) {
        trackingManager.track(name: name, properties: properties)
    }
}
