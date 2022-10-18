//
//  WebViewModel.swift
//  WebSwiftUI
//
//  Created by yoshi on 2022/10/07.
//

import Combine
import Foundation
import WebKit

@MainActor
final class WebViewModel: ObservableObject {
    public static let shared: WebViewModel = .init()
    @MainActor public var url: URL? { uiViewModel?.url }

    @MainActor @Published var updateState: WebViewUpdateState?
    private(set) var uiViewModel: WebSwiftUIViewModel?
    
    // MARK: WKNavigationDelegate
    
    var decidePolicyFor: ((WKWebView, WKNavigationAction) async -> WKNavigationActionPolicy)? = nil
    var decidePolicyForWithPreferences: ((WKWebView, WKNavigationAction, WKWebpagePreferences) async -> (WKNavigationActionPolicy, WKWebpagePreferences))? = nil
    var decidePolicyForWithResponse: ((WKWebView, WKNavigationResponse) async -> WKNavigationResponsePolicy)? = nil
    var didStartProvisionalNavigation: ((WKWebView, WKNavigation) -> Void)? = nil
    var didReceiveServerRedirectForProvisionalNavigation: ((WKWebView, WKNavigation) -> Void)? = nil
    var didFailProvisionalNavigation: ((WKWebView, WKNavigation, Error) -> Void)? = nil
    var didCommit: ((WKWebView, WKNavigation) -> Void)? = nil
    var didFinish: ((WKWebView, WKNavigation) -> Void)? = nil
    var didFail: ((WKWebView, WKNavigation, Error) -> Void)? = nil
    var respondTo: ((WKWebView, URLAuthenticationChallenge) async -> (URLSession.AuthChallengeDisposition, URLCredential?))? = nil
    var webViewWebContentProcessDidTerminate: ((WKWebView) -> Void)? = nil
    var shouldAllowDeprecatedTLSFor: ((WKWebView, URLAuthenticationChallenge) async -> Bool)? = nil
    var navigationAction: ((WKWebView, WKNavigationAction, WKDownload) -> Void)? = nil
    var navigationResponse: ((WKWebView, WKNavigationResponse, WKDownload) -> Void)? = nil
    
    // MARK: WKUIDelegate
    
    var createWebViewWith: ((WKWebView, WKWebViewConfiguration, WKNavigationAction, WKWindowFeatures) -> WKWebView?)? = nil
    var webViewDidClose: ((WKWebView) -> Void)? = nil
    var runJavaScriptAlertPanelWithMessage: ((WKWebView, String, WKFrameInfo) async -> Void)? = nil
    var runJavaScriptConfirmPanelWithMessage: ((WKWebView, String, WKFrameInfo) async -> Bool)? = nil
    var runJavaScriptTextInputPanelWithPrompt: ((WKWebView, String, String?, WKFrameInfo) async -> String?)? = nil
    var decideMediaCapturePermissionsFor: ((WKWebView, WKSecurityOrigin, WKFrameInfo, WKMediaCaptureType) async -> WKPermissionDecision)? = nil
    var requestDeviceOrientationAndMotionPermissionFor: ((WKWebView, WKSecurityOrigin, WKFrameInfo, @escaping (WKPermissionDecision) -> Void) -> Void)? = nil
    var contextMenuConfigurationFor: ((WKWebView, WKContextMenuElementInfo) async -> UIContextMenuConfiguration?)? = nil
    var contextMenuWillPresentForElement: ((WKWebView, WKContextMenuElementInfo) -> Void)? = nil
    var contextMenuForElement: ((WKWebView, WKContextMenuElementInfo, UIContextMenuInteractionCommitAnimating) -> Void)? = nil
    var contextMenuDidEndForElement: ((WKWebView, WKContextMenuElementInfo) -> Void)? = nil
    private var _showLockdownModeFirstUseMessage: Any?
    @available(iOS 16.0, *)
    var showLockdownModeFirstUseMessage: ((WKWebView, String) async -> WKDialogResult)? {
        return _showLockdownModeFirstUseMessage as? ((WKWebView, String) async -> WKDialogResult)
    }
    
    @MainActor func initialize(uiViewModel: WebSwiftUIViewModel) {
        reset()
        WebViewModel.shared.uiViewModel = uiViewModel
    }

    @MainActor func resetWebViewState() {
        WebViewModel.shared.updateState = nil
    }

    @MainActor func current(url: URL?) {
        WebViewModel.shared.uiViewModel?.updateUrl(url: url)
    }

    func subscribe(wkWebView: WKWebView) {
        WebViewModel.shared.uiViewModel?.subscribe(wkWebView: wkWebView)
    }
    
    @MainActor func updateState(state: WebViewUpdateState) {
        WebViewModel.shared.updateState = state
    }
    
    @available(iOS 16.0, *)
    func showLockdownModeFirstUseMessage(_ showLockdownModeFirstUseMessage: @escaping ((WKWebView, String) async -> WKDialogResult)) {
        _showLockdownModeFirstUseMessage = showLockdownModeFirstUseMessage
    }
    
    @MainActor private func reset() {
        updateState = nil
        uiViewModel = nil
        
        decidePolicyFor = nil
        decidePolicyForWithPreferences = nil
        decidePolicyForWithResponse = nil
        didStartProvisionalNavigation = nil
        didReceiveServerRedirectForProvisionalNavigation = nil
        didFailProvisionalNavigation = nil
        didCommit = nil
        didFinish = nil
        didFail = nil
        respondTo = nil
        webViewWebContentProcessDidTerminate = nil
        shouldAllowDeprecatedTLSFor = nil
        navigationAction = nil
        navigationResponse = nil
        
        createWebViewWith = nil
        webViewDidClose = nil
        runJavaScriptAlertPanelWithMessage = nil
        runJavaScriptConfirmPanelWithMessage = nil
        runJavaScriptTextInputPanelWithPrompt = nil
        decideMediaCapturePermissionsFor = nil
        requestDeviceOrientationAndMotionPermissionFor = nil
        contextMenuConfigurationFor = nil
        contextMenuWillPresentForElement = nil
        contextMenuForElement = nil
        contextMenuDidEndForElement = nil
        _showLockdownModeFirstUseMessage = nil
    }
}
