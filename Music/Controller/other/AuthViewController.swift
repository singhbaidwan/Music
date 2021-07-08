//
//  AuthViewController.swift
//  Music
//
//  Created by Dalveer singh on 04/07/21.
//

import UIKit
import WebKit
class AuthViewController: UIViewController,WKNavigationDelegate{
    
    private let webview:WKWebView = {
        let pref = WKWebpagePreferences()
        pref.allowsContentJavaScript = true
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = pref
        let webview = WKWebView(frame: .zero,configuration: config)
        return webview
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "SigIn"
        view.backgroundColor = .systemBackground
        webview.navigationDelegate = self
        view.addSubview(webview)
        guard let url = AuthManager.shared.signInUrl else{
            return
        }
        webview.load(URLRequest(url: url))
    }
    public var completionHandler:((Bool)->Void)?
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webview.frame = view.bounds
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        guard let url = webview.url else{
            return
        }
        // exchange the code for access token after user allow permission
        let component = URLComponents(string: url.absoluteString)
        guard let code = component?.queryItems?.first(where: {$0.name == "code"})?.value else{
            return
        }
        webview.isHidden = true
        print(code)
         AuthManager.shared.exchangeCodeForToken(code: code) { [weak self]success in
            DispatchQueue.main.async {
                self?.navigationController?.popToRootViewController(animated: true)
                self?.completionHandler?(success)
                
            }
        }
    }
    
}
