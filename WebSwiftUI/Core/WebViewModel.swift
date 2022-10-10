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
    public var url: URL? { uiViewModel?.url }

    @Published var updateState: WebViewUpdateState?
    private(set) var uiViewModel: WebSwiftUIViewModel?
    
    func initialize(uiViewModel: WebSwiftUIViewModel) {
        WebViewModel.shared.uiViewModel = uiViewModel
    }

    func resetWebViewState() {
        WebViewModel.shared.updateState = nil
    }

    func current(url: URL?) {
        WebViewModel.shared.uiViewModel?.updateUrl(url: url)
    }

    func subscribe(wkWebView: WKWebView) {
        WebViewModel.shared.uiViewModel?.subscribe(wkWebView: wkWebView)
    }
    
    func updateState(state: WebViewUpdateState) {
        WebViewModel.shared.updateState = state
    }
}
