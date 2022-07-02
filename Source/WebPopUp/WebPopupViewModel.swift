//
//  WebPopupViewModel.swift
//  MobioSDKSwift
//
//  Created by Sun on 01/04/2022.
//

protocol WebPopupViewModelType {
    
    // MARK: - Define
    typealias Listener = (WebPopupViewModelType) -> Void
    
    // MARK: - Property
    var scriptMessageHandler: ScriptMessageHandler! { get }
    var dataDidChange: Listener? { get set }
    var urlRequest: URLRequest! { get }
    mutating func showData()
}

class WebPopupViewModel {
    
    var dataDidChange: Listener?
    var scriptMessageHandler: ScriptMessageHandler! 
    var urlRequest: URLRequest! 
    var urlString: String
    var navigator: WebPopupNavigator
    var useCase: WebPopupUseCase
    
    init(urlString: String, navigator: WebPopupNavigator, useCase: WebPopupUseCase) {
        self.urlString = urlString
        self.navigator = navigator
        self.useCase = useCase
    }
    
    func showData() {
        scriptMessageHandler = ScriptMessageHandler()
        scriptMessageHandler.delegate = self
        guard let url = URL(string: urlString) else { return }
        urlRequest = URLRequest(url: url)
        dataDidChange?(self)
    }
}

extension WebPopupViewModel: WebPopupViewModelType, Navigationable {
    
    func handlerAction(_ message: String) {
        let webPopupActionCase = WebPopupActionCase(rawValue: message)
        switch webPopupActionCase {
        case .moCloseButtonclick:
            print("đóng button")
            navigator.dismiss()
        case .moButtonClick:
            print("tap button")
        case .moPopupLoaded:
            print("Popup did Load")
        default: break
        }
    }
}

extension WebPopupViewModel: ScriptMessageHandlerDelegate {
    
    func pass(data: MobioSDK.Dictionary) {
        if let message = data["message"] as? String {
            handlerAction(message)
        }
        
        if let events = data["events"] as? [MobioSDK.Dictionary] {
            useCase.pushDataPopup(events: events)
        }
    }
}
