import Foundation
import SwiftUI
import WebKit

struct WebView {
    @ObservedObject private var viewModel: WebViewModel
    @ObservedObject private var uiStateModel: WebViewStateModel = .init()

    init(url: URL) {
        viewModel = .init(url: url)
        viewModel.setUIState(uiStateModel)
    }
    
    init(url: String) throws {
        guard let url = URL(string: url) else {
            throw URLError(.badURL)
        }
        self.init(url: url)
    }
}

// MARK: UIViewRepresentable

extension WebView: UIViewRepresentable {
    typealias Coordinator = WebViewCoordinator

    func makeCoordinator() -> Coordinator {
        WebViewCoordinator(viewModel: viewModel)
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
        guard viewModel.willWebViewUpdate else {
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
