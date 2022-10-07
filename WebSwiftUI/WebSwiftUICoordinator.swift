//
//  WebSwiftUICoordinator.swift
//  WebSwiftUI
//
//  Created by yoshi on 2022/10/07.
//

import Foundation
import SwiftUI
import WebKit

public class WebSwiftUICoordinator: NSObject {

    @ObservedObject private var viewModel: WebSwiftUIViewModel

    init(viewModel: WebSwiftUIViewModel) {
        self.viewModel = viewModel
    }
}

// MARK: WKNavigationDelegate

extension WebSwiftUICoordinator: WKNavigationDelegate {

    public func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
    }

    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
    }

    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        viewModel.current(url: webView.url)
    }

    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
    }

    public func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
    }
}

// MARK: WKUIDelegate

extension WebSwiftUICoordinator: WKUIDelegate {

    public func webView(
        _ webView: WKWebView,
        createWebViewWith configuration: WKWebViewConfiguration,
        for navigationAction: WKNavigationAction,
        windowFeatures: WKWindowFeatures
    ) -> WKWebView? {
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        }
        return nil
    }

    public func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationAction: WKNavigationAction,
        decisionHandler: (WKNavigationActionPolicy) -> Void
    ) {
        if let url = navigationAction.request.url?.absoluteString {
            if url.hasPrefix("https://apps.apple.com/") {
                guard let appStoreLink = URL(string: url) else {
                    return
                }
                UIApplication.shared.open(appStoreLink, options: [:]) { _ in
                }
                decisionHandler(WKNavigationActionPolicy.cancel)
            } else if url.hasPrefix("http") {
                decisionHandler(WKNavigationActionPolicy.allow)
            } else {
                decisionHandler(WKNavigationActionPolicy.cancel)
            }
        }
    }
}
