//
//  PopupBuilderStatusRequest.swift
//  MobioSDKSwift
//
//  Created by Sun on 28/04/2022.
//

import Foundation

class PopupBuilderStatusRequest: ServiceBaseRequest {
    
    required convenience init(popupData: PopupData, statusCase: WebStatusCase) {
        let params = PopupBuilderStatusParamParser.createParam(popupData: popupData, statusCase: statusCase)
        self.init(urlString: URLs.trackUrl, event: statusCase.data.event, params: params)
    }
}
