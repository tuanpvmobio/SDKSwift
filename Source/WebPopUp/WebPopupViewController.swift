//
//  WebPopupViewController.swift
//  WebviewHTML
//
//  Created by Sun on 23/11/2021.
//

import UIKit
import WebKit

final class WebPopupViewController: UIViewController {
    
    // MARK: - Property
    var webview = WKWebView()
    var viewModel: WebPopupViewModel! {
        didSet {
            viewModel.dataDidChange = { [unowned self] viewModel in
                self.setupWebView()
            }
        }
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.showData()
    }
    
    // MARK: - View
    private func setupWebView() {
        let contentController = WKUserContentController()
        contentController.add(viewModel.scriptMessageHandler, name: "sumbitToiOS")
        let config = WKWebViewConfiguration()
        config.userContentController = contentController
        webview = WKWebView(frame: view.bounds, configuration: config)
        let javaScript = "window.addEventListener('message', function(e){ webkit.messageHandlers.sumbitToiOS.postMessage(event.data); })"
        webview.evaluateJavaScript(javaScript)
        
        webview.navigationDelegate = self
        webview.load(viewModel.urlRequest)
        view = webview
    }
    
    // MARK: - Bind Data
    func bindViewModel(webPopupViewModel: WebPopupViewModel) {
        viewModel = webPopupViewModel
    }
}

extension WebPopupViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView,
                 didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Start load")
    }
    
    func webView(_ webView: WKWebView,
                 didFinish navigation: WKNavigation!) {
        print("Finished navigating to url \(String(describing: webView.url))")
        guard let result = JSONManager.decode(PopupInfo.self, from: popupJson) else { return }
        var description = result.data.profileInfo.description
        description = description.replacingOccurrences(of: "[", with: "{")
        description = description.replacingOccurrences(of: "]", with: "}")
        webview.evaluateJavaScript("handleReplacePersonalization('\(description)')") { (any, error) in
            print("Error : \(String(describing: error))")
        }
    }
}

let popupJson = """
{
  "message_id": "log_id",
  "title": "TITLE",
  "body": "alert.get(WebPushLog.BODY)",
  "image": "body.get(WebPushLog.IMAGE)",
  "icon": "body.get(WebPushLog.ICON)",
  "url_target": "body.get(WebPushLog.URL_TARGET)",
  "push_type": "popup",
  "data": {
    "popup_type": "popup",
    "popup_id": "popup_id",
    "popup_url": "https://xoso.com.vn/xo-so-mien-bac/xsmb-p1.html",
    "merchant_id": "12222",
    "master_campaign_id": "12344",
    "profile_info": {
      "*|NAME|*": "LAN- mu1edbi toanh",
      "*|VC_CODE|*": "1112222",
      "*|PRIMARY_EMAIL|*": "This is primary email",
      "*|SECONDARY_EMAILS|*": "this is secondary emailsthis is secondary emailsthis is secondary emailsthis is secondary emailsthis is secondary emailsthis is secondary emailsthis is secondary emailsthis is secondary emailsthis is secondary emailsthis is secondary emailsthis is secondary emailsthis is secondary emailsthis is secondary emailsthis is secondary emailsthis is secondary emailsthis is secondary emailsthis is secondary emailsthis is secondary emailsthis is secondary emailsthis is secondary emailsthis is secondary emailsthis is secondary emailsthis is secondary emailsthis is secondary emailsthis is secondary emailsthis is secondary emailsthis is secondary emailsthis is secondary emailsthis is secondary emailsthis is secondary emailsthis is secondary emailsthis is secondary emailsthis is secondary emailsthis is secondary emailsthis is secondary emails"
    },
    "profile_id": "7e6d48c7-e1e4-4532-bcfc-4aafe5576f31",
    "journey_id": "06d595fe-72fd-4d67-a375-a4ce2a5e419b",
    "node_id": "396a7e2a-e34e-4771-8601-ca924c89074b",
    "send_id": "ef0c54f1-cd51-48a9-b2f4-828e26111f1d",
    "code": "PUSH_IN_APP",
    "instance_id": "49a31f77-3ef4-4b6f-a4f8-d53ca5845eb8",
    "web_target": "test25.mobio.vn"
  }
}
"""
