//
//  WebSwiftUIViewModel.swift
//  
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
    @Published private(set) var updateState: WebViewUpdateState?

    private var cancellables = Set<AnyCancellable>()
    
    public init() {}
    
    public func onTapGoback() {
        updateState = .goBack
    }
    
    public func onTapGoForward() {
        updateState = .goForward
    }
    
    public func onTapReload() {
        updateState = .reload
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
    }
}
