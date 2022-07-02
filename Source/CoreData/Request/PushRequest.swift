//
//  PushRequest.swift
//  MobioSDKSwift
//
//  Created by Cuong on 1/23/22.
//

import Foundation

public class PushRequest: CoreDataBaseRequest {
    
    init() {
        super.init(className: Push.self)
    }
    
    init(format: String) {
        let sortDescriptors = PushRequest.makeSortDescriptor(key: "expire", ascending: true)
        super.init(className: Push.self, format: format, sortDescriptors: sortDescriptors)
    }
}

extension PushRequest: CoreDataSortable { }
