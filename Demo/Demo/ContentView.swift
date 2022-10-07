//
//  ContentView.swift
//  Demo
//
//  Created by yoshi on 2022/10/08.
//

import SwiftUI
import WebSwiftUI

struct ContentView: View {
    var body: some View {
        try? WebSwiftUI(url: "https://github.com/yoshiysh/WebSwiftUI")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
