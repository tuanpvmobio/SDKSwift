//
//  HomeViewController.swift
//  ExampleProject
//
//  Created by Sun on 21/12/2021.
//

import UIKit
import MobioSDKSwift

final class HomeViewController: UIViewController {
    
    // MARK: - Property
    var analytics = MobioSDK.shared
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        analytics.screenSetting(title: "Home", controllerName: "HomeViewController", timeVisit: [30])
        addBehaviors([])
        analytics.screenSetting(title: "RechargeConfirm", controllerName: "FavoriteViewController", timeVisit: [3])
        analytics.screenSetting(title: "Recharge", controllerName: "CategoryViewController", timeVisit: [3])
        analytics.screenSetting(title: "SaveMoney", controllerName: "SaveMoneyViewController", timeVisit: [3])
        
        
        let jsonString = """
        {
                "source": "popup_builder",
                "action_time": 1649212163829,
                "type": "dynamic",
                "dynamic": [
                    {
                        "event_key": "lan_test_popup_builder_2",
                        "event_data": {
                            "action_time": 1649212163829
                        },
                        "includedReport": true
                    }
                ]
            }
        """
        if let dict = convertToDictionary(text: jsonString) {
            analytics.track(name: "Home View Did Load", properties: dict)
        }
    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
            }
        }
        return nil
    }
    
    // MARK: - Action
    @IBAction func gotoCategory(_ sender: Any) {
        let viewController = CategoryViewController.instantiate()
        present(viewController, animated: true)
    }
    
    @IBAction func recallApiAction(_ sender: Any) {
        APIRecallManager.shared.fetchFailApi()
    }
    
    @IBAction func makeFailApiAction(_ sender: Any) {
    }
    
    @IBAction func trackAction(_ sender: Any) {
        let properties = ["screenName": "Home"]
        analytics.track(name: "track_button", properties: properties)
    }
}
