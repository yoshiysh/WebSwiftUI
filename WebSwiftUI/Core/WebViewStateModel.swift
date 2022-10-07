//
//  WebViewStateModel.swift
//  WebSwiftUI
//
//  Created by yoshi on 2022/10/07.
//

import Combine
import Foundation
import WebKit

@MainActor
final class WebViewStateModel: ObservableObject {

    @Published var isLoading = false
    @Published var canGoBack = false
    @Published var canGoForward = false
    @Published var estimatedProgress: Double = 0

    private var cancellables = Set<AnyCancellable>()

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
