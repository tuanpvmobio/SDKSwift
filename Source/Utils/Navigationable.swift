//
//  Navigationable.swift
//  MobioSDKSwift
//
//  Created by Sun on 22/03/2022.
//

import UIKit

protocol Navigationable {
    var topViewController: UIViewController? { get }
}

extension Navigationable {
    
    var topViewController: UIViewController? {
        return UIApplication.getTopViewController()
    }
}
