//
//  WebSwiftUI.swift
//  
//
//  Created by yoshi on 2022/10/08.
//

import SwiftUI

public struct WebSwiftUI: View {
    @ObservedObject private var webViewModel: WebViewModel
    @ObservedObject private var viewModel: WebSwiftUIViewModel
    
    public var body: some View {
        WebView(viewModel: webViewModel)
            .onChange(of: viewModel.updateState) { state in
                webViewModel.updateState(for: state)
            }
    }
    
    public init(
        url: URL,
        viewModel: WebSwiftUIViewModel? = nil
    ) {
        webViewModel = .init(url: url)
        self.viewModel = viewModel ?? .init()
        webViewModel.setUIState(self.viewModel)
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
