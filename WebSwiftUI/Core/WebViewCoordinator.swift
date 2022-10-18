//
//  WebViewCoordinator.swift
//  WebSwiftUI
//
//  Created by yoshi on 2022/10/07.
//

import Foundation
import SwiftUI
import WebKit

class WebViewCoordinator: NSObject {
    internal let viewModel: WebViewModel
    
    init(viewModel: WebViewModel) {
        self.viewModel = viewModel
    }
}

// MARK: WKNavigationDelegate

extension WebViewCoordinator: WKNavigationDelegate {

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction) async -> WKNavigationActionPolicy {
        if let action = viewModel.decidePolicyFor {
            return await action(webView, navigationAction)
        }
        return WKNavigationActionPolicy.allow
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, preferences: WKWebpagePreferences) async -> (WKNavigationActionPolicy, WKWebpagePreferences) {
        if let action = viewModel.decidePolicyForWithPreferences {
            return await action(webView, navigationAction, preferences)
        }
        return await (WKNavigationActionPolicy.allow, webView.configuration.defaultWebpagePreferences)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse) async -> WKNavigationResponsePolicy {
        if let action = viewModel.decidePolicyForWithResponse {
            return await action(webView, navigationResponse)
        }
        return WKNavigationResponsePolicy.allow
    }

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        if let action = viewModel.didStartProvisionalNavigation {
            action(webView, navigation)
        }
    }

    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        if let action = viewModel.didReceiveServerRedirectForProvisionalNavigation {
            action(webView, navigation)
        }
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        if let action = viewModel.didFailProvisionalNavigation {
            action(webView, navigation, error)
        }
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        if let action = viewModel.didCommit {
            action(webView, navigation)
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if let action = viewModel.didFinish {
            action(webView, navigation)
        }
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        if let action = viewModel.didFail {
            action(webView, navigation, error)
        }
    }
    
    func webView(_ webView: WKWebView, respondTo challenge: URLAuthenticationChallenge) async -> (URLSession.AuthChallengeDisposition, URLCredential?) {
        if let action = viewModel.respondTo {
            return await action(webView, challenge)
        }
        return (URLSession.AuthChallengeDisposition.performDefaultHandling, nil)
    }
    
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        if let action = viewModel.webViewWebContentProcessDidTerminate {
            action(webView)
        }
    }
    
    func webView(_ webView: WKWebView, shouldAllowDeprecatedTLSFor challenge: URLAuthenticationChallenge) async -> Bool {
        if let action = viewModel.shouldAllowDeprecatedTLSFor {
            return await action(webView, challenge)
        }
        return true
    }
    
    func webView(_ webView: WKWebView, navigationAction: WKNavigationAction, didBecome download: WKDownload) {
        if let action = viewModel.navigationAction {
            action(webView, navigationAction, download)
        }
    }
    
    func webView(_ webView: WKWebView, navigationResponse: WKNavigationResponse, didBecome download: WKDownload) {
        if let action = viewModel.navigationResponse {
            action(webView, navigationResponse, download)
        }
    }
}

// MARK: WKUIDelegate

extension WebViewCoordinator: WKUIDelegate {
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if let action = viewModel.createWebViewWith {
            return action(webView, configuration, navigationAction, windowFeatures)
        }
        return nil
    }
    
    func webViewDidClose(_ webView: WKWebView) {
        if let action = viewModel.webViewDidClose {
            action(webView)
        }
    }
    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo) async {
        if let action = viewModel.runJavaScriptAlertPanelWithMessage {
            return await action(webView, message, frame)
        }
    }
    
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo) async -> Bool {
        if let action = viewModel.runJavaScriptConfirmPanelWithMessage {
            return await action(webView, message, frame)
        }
        return false
    }
    
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo) async -> String? {
        if let action = viewModel.runJavaScriptTextInputPanelWithPrompt {
            return await action(webView, prompt, defaultText, frame)
        }
        return nil
    }
    
    func webView(_ webView: WKWebView, decideMediaCapturePermissionsFor origin: WKSecurityOrigin, initiatedBy frame: WKFrameInfo, type: WKMediaCaptureType) async -> WKPermissionDecision {
        if let action = viewModel.decideMediaCapturePermissionsFor {
            return await action(webView, origin, frame, type)
        }
        return WKPermissionDecision.prompt
    }
    
    func webView(_ webView: WKWebView, requestDeviceOrientationAndMotionPermissionFor origin: WKSecurityOrigin, initiatedByFrame frame: WKFrameInfo, decisionHandler: @escaping (WKPermissionDecision) -> Void) {
        if let action = viewModel.requestDeviceOrientationAndMotionPermissionFor {
            action(webView, origin, frame, decisionHandler)
        }
    }
    
    func webView(_ webView: WKWebView, contextMenuConfigurationFor elementInfo: WKContextMenuElementInfo) async -> UIContextMenuConfiguration? {
        if let action = viewModel.contextMenuConfigurationFor {
            return await action(webView, elementInfo)
        }
        return nil
    }
    
    func webView(_ webView: WKWebView, contextMenuWillPresentForElement elementInfo: WKContextMenuElementInfo) {
        if let action = viewModel.contextMenuWillPresentForElement {
            action(webView, elementInfo)
        }
    }
    
    func webView(_ webView: WKWebView, contextMenuForElement elementInfo: WKContextMenuElementInfo, willCommitWithAnimator animator: UIContextMenuInteractionCommitAnimating) {
        if let action = viewModel.contextMenuForElement {
            action(webView, elementInfo, animator)
        }
    }
    
    func webView(_ webView: WKWebView, contextMenuDidEndForElement elementInfo: WKContextMenuElementInfo) {
        if let action = viewModel.contextMenuDidEndForElement {
            action(webView, elementInfo)
        }
    }

//    @available(iOS 16.0, *)
//    func webView(_ webView: WKWebView, showLockdownModeFirstUseMessage message: String) async -> WKDialogResult {
//        if let action = viewModel.showLockdownModeFirstUseMessage {
//            return await action(webView, message)
//        }
//        return WKDialogResult.showDefault
//    }
}
