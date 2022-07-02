//
//  AppDelegate.swift
//  ExampleProject
//
//  Created by Sun on 21/12/2021.
//

import UIKit
import MobioSDKSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var analytics = MobioSDK.shared
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
   
        let config = Configuration(merchantID: "9cd9e0ce-12bf-492a-a81b-7aeef078b09f")
            .token("f5e27185-b53d-4aee-a9b7-e0579c24d29d")
        analytics.bindConfiguration(configuration: config)
        toMain()
        return true
    }
    
    private func toMain() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController else {
            return
        }
        let navigationController = UINavigationController(rootViewController: viewController)
        guard let window = window else { return }
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
