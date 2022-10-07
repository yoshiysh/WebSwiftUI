import Foundation
import SwiftUI
import WebKit

public struct WebSwiftUI {
    @ObservedObject private var viewModel: WebSwiftUIViewModel
    @ObservedObject private var uiStateModel: WebSwiftUIStateModel = .init()

    public init(url: URL) {
        viewModel = .init(url: url)
        viewModel.setUIState(uiStateModel)
    }
    
    public init(url: String) throws {
        guard let url = URL(string: url) else {
            throw URLError(.badURL)
        }
        self.init(url: url)
    }
}

// MARK: UIViewRepresentable

extension WebSwiftUI: UIViewRepresentable {
    public typealias Coordinator = WebSwiftUICoordinator

    public func makeCoordinator() -> Coordinator {
        WebSwiftUICoordinator(viewModel: viewModel)
    }

    public func makeUIView(context: Context) -> WKWebView {
        let wkWebView = WKWebView()
        let request = URLRequest(url: viewModel.url)

        wkWebView.navigationDelegate = context.coordinator
        wkWebView.uiDelegate = context.coordinator
        wkWebView.load(request)
        viewModel.subscribe(wkWebView: wkWebView)

        return wkWebView
    }

    public func updateUIView(_ wkWebView: WKWebView, context: Context) {
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
