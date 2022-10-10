//
//  ContentView.swift
//  Demo
//
//  Created by yoshi on 2022/10/08.
//

import SwiftUI
import WebSwiftUI

struct ContentView: View {
    @StateObject var viewModel: WebSwiftUIViewModel = .init(url: URL(string: "https://github.com/yoshiysh/WebSwiftUI")!)
    
    var body: some View {
        ZStack(alignment: .bottom) {
            WebSwiftUI(viewModel: viewModel)
            
            ProgressView(value: viewModel.estimatedProgress)
                .opacity(viewModel.isLoading ? 1 : 0)
                .transition(.opacity)
        }
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                Button {
                    viewModel.onTapGoback()
                } label: {
                    Image(systemName: "chevron.left")
                }
                .disabled(!viewModel.canGoBack)

                Button {
                    viewModel.onTapGoForward()
                } label: {
                    Image(systemName: "chevron.right")
                }
                .disabled(!viewModel.canGoForward)

                Spacer()

                Button {
                    viewModel.onTapReload()
                } label: {
                    Image(systemName: "arrow.clockwise")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
