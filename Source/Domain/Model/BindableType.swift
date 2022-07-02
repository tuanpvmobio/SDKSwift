//
//  BindableType.swift
//  SimpleDemoCleanArchitecture
//
//  Created by KIMOCHI on 10/25/20.
//  Copyright © 2020 trinh.giang.dong. All rights reserved.
//

import UIKit

public protocol BindableType: class {
    associatedtype ViewModelType
    
    var viewModel: ViewModelType! { get set }
    
    func bindViewModel(to model: Self.ViewModelType)
}

extension BindableType {
    public func bindViewModel(to model: Self.ViewModelType) {
        viewModel = model
    }
}
