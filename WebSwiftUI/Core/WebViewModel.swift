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

    @Published var willWebViewUpdate = false

    private(set) var uiState: WebSwiftUIViewModel?
    private(set) var updateState: WebViewUpdateState?
    private(set) var url: URL

    init(url: URL) {
        self.url = url
    }

    func setUIState(_ uiState: WebSwiftUIViewModel) {
        self.uiState = uiState
    }

    func updateState(for updateState: WebViewUpdateState?) {
        self.updateState = updateState
        willWebViewUpdate = true
    }

    func resetWebViewState() {
        updateState = nil
    }

    func current(url: URL?) {
        guard let url = url else {
            return
        }
        self.url = url
    }

    func subscribe(wkWebView: WKWebView) {
        uiState?.subscribe(wkWebView: wkWebView)
    }
}
