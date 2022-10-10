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
    @ObservedObject private var webViewModel: WebViewModel = .shared
    
    public var body: some View {
        WebView(updater: updater, viewModel: webViewModel)
            .onChange(of: webViewModel.updateState) { state in
                guard state != nil else {
                    return
                }
                updater.willUpdate()
            }
    }
    
    public init(viewModel: WebSwiftUIViewModel) {
        self.viewModel = viewModel
        webViewModel.initialize(uiViewModel: self.viewModel)
    }
}

struct WebSwiftUI_Previews: PreviewProvider {
    static var previews: some View {
        WebSwiftUI(
            viewModel: WebSwiftUIViewModel.init(url: URL(string: "https://github.com/yoshiysh/WebSwiftUI")!)
        )
    }
}
