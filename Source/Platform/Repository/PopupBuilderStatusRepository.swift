//
//  PopupBuilderStatusRepository.swift
//  MobioSDKSwift
//
//  Created by Sun on 28/04/2022.
//

import Foundation

protocol PopupBuilderStatusRepositoryType {
    func sendPopupBuilderStatus(popupData: PopupData, statusCase: WebStatusCase) 
}

final class PopupBuilderStatusRepository: ServiceBaseRepository {
    
}

extension PopupBuilderStatusRepository: PopupBuilderStatusRepositoryType {
    
    func sendPopupBuilderStatus(popupData: PopupData, statusCase: WebStatusCase) {
        guard let api = api else { return }
        let input = PopupBuilderStatusRequest(popupData: popupData, statusCase: statusCase)
        api.request(input: input) { (object: PopupBuilderResponse?, error) in
        }
    }
}
