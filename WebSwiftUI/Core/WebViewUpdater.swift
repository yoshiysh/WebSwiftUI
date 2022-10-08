//
//  WebViewUpdater.swift
//  WebSwiftUI
//
//  Created by yoshi on 2022/10/09.
//

import Foundation

@MainActor
final class WebViewUpdater: ObservableObject {
    @Published private(set) var willWebViewUpdate = false
    
    func willUpdate() {
        self.willWebViewUpdate = true
    }
}
