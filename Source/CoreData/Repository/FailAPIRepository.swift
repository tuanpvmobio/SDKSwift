//
//  FailAPIRepository.swift
//  MobioSDKSwift
//
//  Created by Sun on 16/02/2022.
//

import Foundation

protocol FailAPIRepositoryType {
    func isFailAPIExist(object: FailAPI) -> Bool
}

final class FailAPIRepository {
    
    typealias T = FailAPI
    
    internal var manager: DBManagerType!
    
    init(manager: DBManagerType) {
        self.manager = manager
    }
}

extension FailAPIRepository: CoreDataBaseRepositoryType {
    
    func getList() -> [T] {
        let failAPIRequest = FailAPIRequest()
        return getArrayData(input: failAPIRequest)
    }
}

extension FailAPIRepository: FailAPIRepositoryType {
    
    func isFailAPIExist(object: T) -> Bool {
        let list = getList()
        return list.contains(object)
    }
}
