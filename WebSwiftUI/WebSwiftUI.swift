//
//  WebSwiftUI.swift
//  
//
//  Created by yoshi on 2022/10/08.
//

import SwiftUI

public struct WebSwiftUI: View {
    private var url: URL
    
    public var body: some View {
        WebView(url: url)
    }
    
    init(url: URL) {
        self.url = url
    }
    
    init(url: String) throws {
        guard let url = URL(string: url) else {
            throw URLError(.badURL)
        }
        self.init(url: url)
    }
}

struct WebSwiftUI_Previews: PreviewProvider {
    static var previews: some View {
        try? WebSwiftUI(url: "https://github.com/yoshiysh/WebSwiftUI")
    }
}
