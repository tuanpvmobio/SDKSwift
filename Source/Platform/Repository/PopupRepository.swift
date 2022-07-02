//
//  PopupRepository.swift
//  MobioSDKSwift
//
//  Created by Sun on 04/04/2022.
//

import Foundation

protocol PopupRepositoryType {
    func getPopupData()
}

final class PopupRepository: ServiceBaseRepository {
}

extension PopupRepository: PopupRepositoryType {
    
    func getPopupData() {
        guard let api = api else { return }
        let input = PopupRequest()
        api.request(input: input) { (object: PopupInfoResponse?, error) in
            if let object = object {
                print(object)
            }
        }
    }
}
