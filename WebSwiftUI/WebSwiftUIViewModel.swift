//
//  WebSwiftUIViewModel.swift
//  WebSwiftUI
//
//  Created by yoshi on 2022/10/08.
//

import Combine
import Foundation
import WebKit

@MainActor
public final class WebSwiftUIViewModel: ObservableObject {
    @Published public private(set) var isLoading = false
    @Published public private(set) var canGoBack = false
    @Published public private(set) var canGoForward = false
    @Published public private(set) var estimatedProgress: Double = 0
    
    private(set) var url: URL

    private var cancellables = Set<AnyCancellable>()
    
    public init(url: URL) {
        self.url = url
    }
    
    public convenience init(url: String) throws {
        guard let url = URL(string: url) else {
            throw URLError(.badURL)
        }
        self.init(url: url)
    }
    
    public func updateUrl(url: URL?) {
        guard let url = url else {
            return
        }
        self.url = url
    }
    
    public func onTapGoback() {
        updateState(state: .goBack)
    }
    
    public func onTapGoForward() {
        updateState(state: .goForward)
    }
    
    public func onTapReload() {
        updateState(state: .reload)
    }
    
    func subscribe(wkWebView: WKWebView) {
        wkWebView.publisher(for: \.isLoading)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                self?.isLoading = value
            }
            .store(in: &cancellables)

        wkWebView.publisher(for: \.canGoBack)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                self?.canGoBack = value
            }
            .store(in: &cancellables)

        wkWebView.publisher(for: \.canGoForward)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                self?.canGoForward = value
            }
            .store(in: &cancellables)

        wkWebView.publisher(for: \.estimatedProgress)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                self?.estimatedProgress = value
            }
            .store(in: &cancellables)
        
        wkWebView.publisher(for: \.url, options: .new)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                self?.updateUrl(url: value)
            }
            .store(in: &cancellables)
    }
    
    private func updateState(state: WebViewUpdateState) {
        WebViewModel.shared.updateState(state: state)
    }
}
