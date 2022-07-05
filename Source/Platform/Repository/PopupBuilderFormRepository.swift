//
//  PopupBuilderFormRepository.swift
//  MobioSDKSwift
//
//  Created by Sun on 26/04/2022.
//

import Foundation

protocol PopupBuilderFormRepositoryType {
    func sendFormData(popupData: PopupData, actionData: PopupBuilderActionData, submitFormCase: SubmitFormCase)
}

final class PopupBuilderFormRepository: ServiceBaseRepository {
}

extension PopupBuilderFormRepository: PopupBuilderFormRepositoryType {
    
    func sendFormData(popupData: PopupData, actionData: PopupBuilderActionData, submitFormCase: SubmitFormCase) {
        guard let api = api else { return }
        let input = PopupBuilderFormRequest(popupData: popupData, actionData: actionData, submitFormCase: submitFormCase)
        api.request(input: input) { (object: PopupBuilderResponse?, error) in
        }
    }
}
