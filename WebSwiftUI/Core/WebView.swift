//
//  WebView.swift
//  WebSwiftUI
//
//  Created by yoshi on 2022/10/07.
//

import Foundation
import SwiftUI
import WebKit

struct WebView {
    @ObservedObject var updater: WebViewUpdater
    private let viewModel: WebViewModel = .shared
}

// MARK: UIViewRepresentable

extension WebView: UIViewRepresentable {
    typealias Coordinator = WebViewCoordinator

    func makeCoordinator() -> Coordinator {
        WebViewCoordinator()
    }

    func makeUIView(context: Context) -> WKWebView {
        let wkWebView = WKWebView()
        let request = URLRequest(url: viewModel.url)

        wkWebView.navigationDelegate = context.coordinator
        wkWebView.uiDelegate = context.coordinator
        wkWebView.load(request)
        viewModel.subscribe(wkWebView: wkWebView)

        return wkWebView
    }

    func updateUIView(_ wkWebView: WKWebView, context: Context) {
        if !updater.willWebViewUpdate {
            return
        }

        switch viewModel.updateState {
        case .goBack:
            _ = wkWebView.goBack()
        case .goForward:
            _ = wkWebView.goForward()
        case .reload:
            let request = URLRequest(url: viewModel.url)
            _ = wkWebView.load(request)
        case nil:
            break
        }
        viewModel.resetWebViewState()
    }
}
