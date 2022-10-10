//
//  WebView.swift
//  WebSwiftUI
//
//  Created by yoshi on 2022/10/07.
//

import Foundation
import SwiftUI
import WebKit

@MainActor
struct WebView {
    @ObservedObject private var updater: WebViewUpdater
    private let viewModel: WebViewModel
    
    init(updater: WebViewUpdater, viewModel: WebViewModel) {
        self.updater = updater
        self.viewModel = viewModel
    }
}

// MARK: UIViewRepresentable

extension WebView: UIViewRepresentable {
    typealias Coordinator = WebViewCoordinator

    func makeCoordinator() -> Coordinator {
        WebViewCoordinator(viewModel: viewModel)
    }

    func makeUIView(context: Context) -> WKWebView {
        let configuration = WKWebViewConfiguration()
        let wkWebView = WKWebView(frame: .zero, configuration: configuration)
        let request = URLRequest(url: viewModel.url!)

        wkWebView.navigationDelegate = context.coordinator
        wkWebView.uiDelegate = context.coordinator
        wkWebView.allowsBackForwardNavigationGestures = true
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
            let request = URLRequest(url: viewModel.url!)
            _ = wkWebView.load(request)
        case nil:
            break
        }
        viewModel.resetWebViewState()
    }
}
