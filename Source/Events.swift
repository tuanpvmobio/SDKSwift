//
//  Events.swift
//  AppDemo
//
//  Created by LinhNobi on 26/08/2021.
//

import Foundation
import UIKit

extension MobioSDK {
    
    public func screen<P: Codable>(screenTitle: String, category: String? = nil, properties: P?) {
    }
    
    public func scroll(_ scrollView: UIScrollView) {
        Scroll.shared.trackScrollView(scrollView)
    }
}
