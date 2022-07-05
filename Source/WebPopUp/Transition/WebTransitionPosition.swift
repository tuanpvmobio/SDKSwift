//
//  WebTransitionPosition.swift
//
//  Created by Sun on 20/05/2022.
//

import UIKit

enum WebTransitionPosition: String {
    case top = "tc"
    case bottom = "bc"
    case center = "cc"
    
    func getFrame(height: CGFloat) -> CGRect {
        let statusBarHeight = Screen.statusBarHeight
        switch self {
        case .top:
            return CGRect(x: 0, y: statusBarHeight, width: Screen.width, height: height)
        case .bottom:
            let y = Screen.height - height
            return CGRect(x: 0, y: y, width: Screen.width, height: height)
        case .center:
            return CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height)
        }
    }
}
