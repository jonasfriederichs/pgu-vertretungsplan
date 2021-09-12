//
//  DatesWebView.swift
//  DatesWebView
//
//  Created by Wolf Jonas Friederichs on 9/12/21.
//

import Foundation
import Combine
import SwiftUI
import WebKit
import UIKit

struct Webview: UIViewRepresentable {
    let url: URL
    let navigationHelper = WebViewHelper()

    func makeUIView(context: UIViewRepresentableContext<Webview>) -> WKWebView {
        let webview = WKWebView()
        webview.navigationDelegate = navigationHelper

        let request = URLRequest(url: self.url, cachePolicy: .returnCacheDataElseLoad)
        webview.load(request)

        return webview
    }

    func updateUIView(_ webview: WKWebView, context: UIViewRepresentableContext<Webview>) {
        let request = URLRequest(url: self.url, cachePolicy: .returnCacheDataElseLoad)
        webview.load(request)
    }
}

class WebViewHelper: NSObject, WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("webview didFinishNavigation")
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("didStartProvisionalNavigation")
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("webviewDidCommit")
    }
    
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        print("didReceiveAuthenticationChallenge")
        completionHandler(.performDefaultHandling, nil)
    }
}
