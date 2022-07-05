//
//  WebPopupViewModel.swift
//  MobioSDKSwift
//
//  Created by Sun on 01/04/2022.
//

import WebKit

protocol WebPopupViewModelType {
    mutating func showData()
    var remoteNotificationData: RemoteNotificationData { get }
}

protocol PopupBuilderDelegate {
    func passDataPopupBuilder(scriptMessageHandler: ScriptMessageHandler, urlRequest: URLRequest)
}

protocol HTMLDelegate {
    func passDataBody(body: String)
}

class WebPopupViewModel: NSObject, WebPopupViewModelType {
    
    var navigator: WebPopupNavigator
    var useCase: WebPopupUseCase
    var popupBuilderDelegate: PopupBuilderDelegate?
    var remoteNotificationData: RemoteNotificationData
    var htmlDelegate: HTMLDelegate?
    var webview = WKWebView()
    
    init(remoteNotificationData: RemoteNotificationData, navigator: WebPopupNavigator, useCase: WebPopupUseCase) {
        self.remoteNotificationData = remoteNotificationData
        self.navigator = navigator
        self.useCase = useCase
    }
    
    func showData() {
        switch remoteNotificationData.alert.contentType {
        case "popup": setupPopupBuilderData()
        case "html": setupHTMLData()
        default: break
        }
        setupWebview()
    }
    
    private func setupWebview() {
        webview.navigationDelegate = self
        webview.uiDelegate = self
        webview.backgroundColor = .clear
        webview.isOpaque = false
    }
    
    func setupPopupBuilderData() {
        let config = createConfig()
        webview = WKWebView(frame: UIScreen.main.bounds, configuration: config)
        let data = remoteNotificationData.data
        guard let popupURL = data?.popupURL,
              let url = URL(string: popupURL) else { return }
        let urlRequest = URLRequest(url: url)
        webview.load(urlRequest)
    }
    
    private func createScript() -> WKUserScript {
        let source = "window.addEventListener('message', function(e){ webkit.messageHandlers.sumbitToiOS.postMessage(event.data); })"
        let script = WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: false)
        return script
    }
    
    private func createConfig() -> WKWebViewConfiguration {
        let scriptMessageHandler = ScriptMessageHandler()
        scriptMessageHandler.delegate = self
        let contentController = WKUserContentController()
        contentController.add(scriptMessageHandler, name: "sumbitToiOS")
        let script = createScript()
        contentController.addUserScript(script)
        let config = WKWebViewConfiguration()
        config.userContentController = contentController
        return config
    }
    
    func setupHTMLData() {
        webview = WKWebView(frame: UIScreen.main.bounds)
        let body = remoteNotificationData.alert.body ?? ""
        webview.loadHTMLString(body, baseURL: nil)
        navigator.presentPopup(webview: webview, webPopupType: .html)
    }
    
    func handleMessage(_ message: String, actionData: PopupBuilderActionData) {
        guard let popupData = remoteNotificationData.data else { return }
        let messageCase = WebPopupMessageCase(rawValue: message)
        switch messageCase {
        case .moCloseButtonclick where actionData.page == 1:
            WebPopupStatusManager.pushDataStatusPopup(popupData: popupData, statusCase: .close)
            navigator.dismiss()
        case .moCloseButtonclick where actionData.page == 2:
            navigator.dismiss()
        case .moButtonClick where actionData.includedReport == 1:
            WebPopupFormManager.pushDataForm(popupData: popupData, actionData: actionData, submitFormCase: .report)
        case .moPopupLoaded:
            WebPopupStatusManager.pushDataStatusPopup(popupData: popupData, statusCase: .open)
            navigator.presentPopup(webview: webview, webPopupType: .url(popupData: popupData, actionData: actionData))
        case .moSubmitButtonClick:
            WebPopupFormManager.pushDataForm(popupData: popupData, actionData: actionData, submitFormCase: .submit)
        default: break
        }
    }
    
    func handleAction(_ action: PopupBuilderAction, actionData: PopupBuilderActionData) {
        let actionCase = WebPopupActionCase(value: action)
        switch actionCase {
        case .close where actionData.hasSecondPage == false:
            navigator.dismiss()
        case .redirect(let redirectURL):
            navigator.redirect(urlString: redirectURL)
        case .download(let downloadUrl):
            useCase.download(from: downloadUrl)
        case .none:
            break
        case .close:
            break
        }
    }
}

extension WebPopupViewModel: ScriptMessageHandlerDelegate {
    
    func pass(actionData: PopupBuilderActionData) {
        let message = actionData.message
        handleMessage(message, actionData: actionData)
        if let actions = actionData.actions {
            actions.forEach { action in
                handleAction(action, actionData: actionData)
            }
        }
    }
}

extension WebPopupViewModel: WKNavigationDelegate {
    
    public func webView(_ webView: WKWebView,
                        didStartProvisionalNavigation navigation: WKNavigation!) {
    }
    
    public func webView(_ webView: WKWebView,
                        didFinish navigation: WKNavigation!) {
        guard let data = remoteNotificationData.data else { return }
        let profileInfo = data.profileInfo
        var description = profileInfo.description
        description = description.replacingOccurrences(of: "[", with: "{")
        description = description.replacingOccurrences(of: "]", with: "}")
        webview.evaluateJavaScript("showPopup('\(data)')") { (any, error) in
        }
    }
}

extension WebPopupViewModel: WKUIDelegate {
    
    public func webView(_ webView: WKWebView,
                        createWebViewWith configuration: WKWebViewConfiguration,
                        for navigationAction: WKNavigationAction,
                        windowFeatures: WKWindowFeatures) -> WKWebView? {
        let redirectURL = navigationAction.request.url?.description
        navigator.redirect(urlString: redirectURL)
        return nil
    }
}
