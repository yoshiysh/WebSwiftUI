//
//  WebSwiftUI.swift
//  
//
//  Created by yoshi on 2022/10/08.
//

import SwiftUI

public struct WebSwiftUI: View {
    @StateObject private var updater: WebViewUpdater = .init()
    @ObservedObject private var viewModel: WebSwiftUIViewModel
    private var webViewModel: WebViewModel = .shared
    
    public var body: some View {
        WebView(updater: updater)
            .onChange(of: viewModel.updateState) { state in
                guard let state = state else {
                    return
                }
                webViewModel.updateState(for: state)
                updater.willUpdate()
            }
    }
    
    public init(
        url: URL,
        viewModel: WebSwiftUIViewModel? = nil
    ) {
        self.viewModel = viewModel ?? .init()
        webViewModel.initialize(url: url, uiViewModel: self.viewModel)
    }
    
    public init(
        url: String,
        viewModel: WebSwiftUIViewModel? = nil
    ) throws {
        guard let url = URL(string: url) else {
            throw URLError(.badURL)
        }
        self.init(url: url, viewModel: viewModel)
    }
}

struct WebSwiftUI_Previews: PreviewProvider {
    static var previews: some View {
        try? WebSwiftUI(url: "https://github.com/yoshiysh/WebSwiftUI")
    }
}
