//
//  WebSwiftUI+WKNavigationDelegate.swift
//  WebSwiftUI
//
//  Created by Yoshiki Hemmi on 2022/10/17.
//

import Foundation
import WebKit

public extension WebSwiftUI {
    /// optional func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction) async -> WKNavigationActionPolicy
    func decidePolicyFor(_ decidePolicyFor: @escaping (WKWebView, WKNavigationAction) async -> WKNavigationActionPolicy) -> Self {
        webViewModel.decidePolicyFor = decidePolicyFor
        return self
    }
    
    ///  optional func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, preferences: WKWebpagePreferences) async -> (WKNavigationActionPolicy, WKWebpagePreferences)
    func decidePolicyFor(_ decidePolicyFor: @escaping (WKWebView, WKNavigationAction, WKWebpagePreferences) async -> (WKNavigationActionPolicy, WKWebpagePreferences)) -> Self {
        webViewModel.decidePolicyForWithPreferences = decidePolicyFor
        return self
    }
    
    /// optional func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse) async -> WKNavigationResponsePolicy
    func decidePolicyFor(_ decidePolicyFor: @escaping (WKWebView, WKNavigationResponse) async -> WKNavigationResponsePolicy) -> Self {
        webViewModel.decidePolicyForWithResponse = decidePolicyFor
        return self
    }
    
    /// optional func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!)
    func didStartProvisionalNavigation(_ didStartProvisionalNavigation: @escaping (WKWebView, WKNavigation) -> Void) -> Self {
        webViewModel.didStartProvisionalNavigation = didStartProvisionalNavigation
        return self
    }
    
    /// optional func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!)
    func didReceiveServerRedirectForProvisionalNavigation(_ didReceiveServerRedirectForProvisionalNavigation: @escaping (WKWebView, WKNavigation) -> Void) -> Self {
        webViewModel.didReceiveServerRedirectForProvisionalNavigation = didReceiveServerRedirectForProvisionalNavigation
        return self
    }
    
    /// optional func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error)
    func didFailProvisionalNavigation(_ didFailProvisionalNavigation: @escaping (WKWebView, WKNavigation, Error) -> Void) -> Self {
        webViewModel.didFailProvisionalNavigation = didFailProvisionalNavigation
        return self
    }
    
    /// optional func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!)
    func didCommit(_ didCommit: @escaping (WKWebView, WKNavigation) -> Void) -> Self {
        webViewModel.didCommit = didCommit
        return self
    }
    
    /// optional func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!)
    func didFinish(_ didFinish: @escaping (WKWebView, WKNavigation) -> Void) -> Self {
        webViewModel.didFinish = didFinish
        return self
    }
    
    /// optional func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error)
    func didFail(_ didFail: @escaping (WKWebView, WKNavigation, Error) -> Void) -> Self {
        webViewModel.didFail = didFail
        return self
    }
    
    /// optional func webView(_ webView: WKWebView, respondTo challenge: URLAuthenticationChallenge) async -> (URLSession.AuthChallengeDisposition, URLCredential?)
    func respondTo(_ respondTo: @escaping (WKWebView, URLAuthenticationChallenge) async -> (URLSession.AuthChallengeDisposition, URLCredential?)) -> Self {
        webViewModel.respondTo = respondTo
        return self
    }
    
    /// optional func webViewWebContentProcessDidTerminate(_ webView: WKWebView)
    func webViewWebContentProcessDidTerminate(_ webViewWebContentProcessDidTerminate: @escaping (WKWebView) -> Void) -> Self {
        webViewModel.webViewWebContentProcessDidTerminate = webViewWebContentProcessDidTerminate
        return self
    }
    
    /// optional func webView(_ webView: WKWebView, shouldAllowDeprecatedTLSFor challenge: URLAuthenticationChallenge) async -> Bool
    func shouldAllowDeprecatedTLSFor(_ shouldAllowDeprecatedTLSFor: @escaping (WKWebView, URLAuthenticationChallenge) async -> Bool) -> Self {
        webViewModel.shouldAllowDeprecatedTLSFor = shouldAllowDeprecatedTLSFor
        return self
    }
    
    /// optional func webView(_ webView: WKWebView, navigationAction: WKNavigationAction, didBecome download: WKDownload)
    @available(iOS 14.5, *)
    func navigationAction(_ navigationAction: @escaping (WKWebView, WKNavigationAction, WKDownload) -> Void) -> Self {
        webViewModel.navigationAction = navigationAction
        return self
    }
    
    /// optional func webView(_ webView: WKWebView, navigationResponse: WKNavigationResponse, didBecome download: WKDownload)
    @available(iOS 14.5, *)
    func navigationResponse(_ navigationResponse: @escaping (WKWebView, WKNavigationResponse, WKDownload) -> Void) -> Self {
        webViewModel.navigationResponse = navigationResponse
        return self
    }
}
