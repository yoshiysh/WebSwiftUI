//
//  WebSwiftUIViewModel.swift
//  WebSwiftUI
//
//  Created by yoshi on 2022/10/07.
//

import Combine
import Foundation
import WebKit

@MainActor
final class WebSwiftUIViewModel: ObservableObject {

    @Published var willWebViewUpdate = false

    private(set) var uiState: WebSwiftUIStateModel?
    private(set) var updateState: WebSwiftUIUpdateState?
    private(set) var url: URL

    init(url: URL) {
        self.url = url
    }

    func setUIState(_ uiState: WebSwiftUIStateModel) {
        self.uiState = uiState
    }

    func updateState(for updateState: WebSwiftUIUpdateState?) {
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
