//
//  WebSwiftUI+WKUIDelegate.swift.swift
//  WebSwiftUI
//
//  Created by Yoshiki Hemmi on 2022/10/17.
//

import Foundation
import WebKit

public extension WebSwiftUI {
    /// optional func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView?
    func createWebViewWith(_ createWebViewWith: @escaping (WKWebView, WKWebViewConfiguration, WKNavigationAction, WKWindowFeatures) -> WKWebView?) -> Self {
        webViewModel.createWebViewWith = createWebViewWith
        return self
    }
    
    /// optional func webViewDidClose(_ webView: WKWebView)
    func webViewDidClose(_ webViewDidClose: @escaping (WKWebView) -> Void) -> Self {
        webViewModel.webViewDidClose = webViewDidClose
        return self
    }
    
    /// optional func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo) async
    func runJavaScriptAlertPanelWithMessage(_ runJavaScriptAlertPanelWithMessage: @escaping (WKWebView, String, WKFrameInfo) async -> Void) -> Self {
        webViewModel.runJavaScriptAlertPanelWithMessage = runJavaScriptAlertPanelWithMessage
        return self
    }
    
    /// optional func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo) async -> Bool
    func runJavaScriptConfirmPanelWithMessage(_ runJavaScriptConfirmPanelWithMessage: @escaping (WKWebView, String, WKFrameInfo) async -> Bool) -> Self {
        webViewModel.runJavaScriptConfirmPanelWithMessage = runJavaScriptConfirmPanelWithMessage
        return self
    }
    
    /// optional func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo) async -> String?
    func runJavaScriptTextInputPanelWithPrompt(_ runJavaScriptTextInputPanelWithPrompt: @escaping (WKWebView, String, String?, WKFrameInfo) async -> String?) -> Self {
        webViewModel.runJavaScriptTextInputPanelWithPrompt = runJavaScriptTextInputPanelWithPrompt
        return self
    }

    /// optional func webView(_ webView: WKWebView, decideMediaCapturePermissionsFor origin: WKSecurityOrigin, initiatedBy frame: WKFrameInfo, type: WKMediaCaptureType) async -> WKPermissionDecision
    @available(iOS 15.0, *)
    func decideMediaCapturePermissionsFor(_ decideMediaCapturePermissionsFor: @escaping (WKWebView, WKSecurityOrigin, WKFrameInfo, WKMediaCaptureType) async -> WKPermissionDecision) -> Self {
        webViewModel.decideMediaCapturePermissionsFor = decideMediaCapturePermissionsFor
        return self
    }
    
    /// optional func webView(_ webView: WKWebView, requestDeviceOrientationAndMotionPermissionFor origin: WKSecurityOrigin, initiatedByFrame frame: WKFrameInfo, decisionHandler: @escaping (WKPermissionDecision) -> Void)
    @available(iOS 15.0, *)
    func requestDeviceOrientationAndMotionPermissionFor(_ requestDeviceOrientationAndMotionPermissionFor: @escaping (WKWebView, WKSecurityOrigin, WKFrameInfo, @escaping (WKPermissionDecision) -> Void) -> Void) -> Self {
        webViewModel.requestDeviceOrientationAndMotionPermissionFor = requestDeviceOrientationAndMotionPermissionFor
        return self
    }
    
    /// optional func webView(_ webView: WKWebView, contextMenuConfigurationFor elementInfo: WKContextMenuElementInfo) async -> UIContextMenuConfiguration?
    func contextMenuConfigurationFor(_ contextMenuConfigurationFor: @escaping (WKWebView, WKContextMenuElementInfo) async -> UIContextMenuConfiguration?) -> Self {
        webViewModel.contextMenuConfigurationFor = contextMenuConfigurationFor
        return self
    }
    
    /// optional func webView(_ webView: WKWebView, contextMenuWillPresentForElement elementInfo: WKContextMenuElementInfo)
    func contextMenuWillPresentForElement(_ contextMenuWillPresentForElement: @escaping (WKWebView, WKContextMenuElementInfo) -> Void) -> Self {
        webViewModel.contextMenuWillPresentForElement = contextMenuWillPresentForElement
        return self
    }
    
    /// optional func webView(_ webView: WKWebView, contextMenuForElement elementInfo: WKContextMenuElementInfo, willCommitWithAnimator animator: UIContextMenuInteractionCommitAnimating)
    func contextMenuForElement(_ contextMenuForElement: @escaping (WKWebView, WKContextMenuElementInfo, UIContextMenuInteractionCommitAnimating) -> Void) -> Self {
        webViewModel.contextMenuForElement = contextMenuForElement
        return self
    }
    
    /// optional func webView(_ webView: WKWebView, contextMenuDidEndForElement elementInfo: WKContextMenuElementInfo)
    func contextMenuDidEndForElement(_ contextMenuDidEndForElement: @escaping (WKWebView, WKContextMenuElementInfo) -> Void) -> Self {
        webViewModel.contextMenuDidEndForElement = contextMenuDidEndForElement
        return self
    }
    
    /// optional func webView(_ webView: WKWebView, showLockdownModeFirstUseMessage message: String) async -> WKDialogResult
    @available(iOS 16.0, *)
    func showLockdownModeFirstUseMessage(_ showLockdownModeFirstUseMessage: @escaping (WKWebView, String) async -> WKDialogResult) -> Self {
        webViewModel.showLockdownModeFirstUseMessage(showLockdownModeFirstUseMessage)
        return self
    }
}
