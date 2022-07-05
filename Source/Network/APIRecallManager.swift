//
//  APIRecallManager.swift
//  MobioSDKSwift
//
//  Created by Sun on 16/02/2022.
//

import Foundation

public struct APIRecallManager {
    
    public static let shared = APIRecallManager()
    var internetManager = InternetManager()
    let failApiRepository = FailAPIRepository(manager: DBManager.shared)
    let recallAPIRepository = RecallApiRepository(api: HTTPClient.shared)
    
    private init() { }
    
    public func fetchFailApi() {
        let failApiList = failApiRepository.getList()
        failApiList.forEach { failApi in
            recallAPIRepository.recall(failAPI: failApi) { recallApiResult in
                failApiRepository.delete(object: failApi)
            }
        }
    }
    
    mutating func setupInternetManager() {
        internetManager.delegate = self
        internetManager.startObserverInternet()
    }
}

extension APIRecallManager: InternetManagerDelegate {
    
    func haveInternet() {
        fetchFailApi()
    }
    
    func dontHaveInternet() {
        // MARK: - TODO: do something
    }
}
