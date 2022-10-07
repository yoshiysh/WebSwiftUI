//
//  WebSwiftUI.swift
//  
//
//  Created by yoshi on 2022/10/08.
//

import SwiftUI

public struct WebSwiftUI: View {
    @ObservedObject var viewModel: WebSwiftUIViewModel
    private var url: URL
    
    public var body: some View {
        WebView(url: url, uiStateModel: viewModel)
    }
    
    public init(
        url: URL,
        viewModel: WebSwiftUIViewModel? = nil
    ) {
        self.url = url
        self.viewModel = viewModel ?? .init()
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
