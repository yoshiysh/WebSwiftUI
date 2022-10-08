//
//  WebViewModel.swift
//  WebSwiftUI
//
//  Created by yoshi on 2022/10/07.
//

import Combine
import Foundation
import WebKit

final class WebViewModel {
    public static let shared: WebViewModel = .init()
    public var url: URL { _url! }

    private(set) var updater: WebViewUpdater?
    private(set) var uiViewModel: WebSwiftUIViewModel?
    private(set) var updateState: WebViewUpdateState?
    private var _url: URL?
    
    private init() {}
    
    func initialize(url: URL, uiViewModel: WebSwiftUIViewModel) {
        WebViewModel.shared.uiViewModel = uiViewModel
        WebViewModel.shared.updateState = nil
        WebViewModel.shared.current(url: url)
    }
    
    func updateState(for updateState: WebViewUpdateState?) {
        WebViewModel.shared.updateState = updateState
    }

    func resetWebViewState() {
        WebViewModel.shared.updateState = nil
    }

    func current(url: URL?) {
        guard let url = url else {
            return
        }
        WebViewModel.shared._url = url
    }

    @MainActor func subscribe(wkWebView: WKWebView) {
        WebViewModel.shared.uiViewModel?.subscribe(wkWebView: wkWebView)
    }
}
