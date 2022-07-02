//
//  Navigationable.swift
//  MobioSDKSwift
//
//  Created by Sun on 22/03/2022.
//

import UIKit

protocol Navigationable {
    var navigationController: UINavigationController? { get }
}

extension Navigationable {
    
    var navigationController: UINavigationController? {
        let application = UIApplication.shared
        let navigationController = application.windows[0].rootViewController as? UINavigationController
        return navigationController
    }
}
