//
//  OffGridApp.swift
//  OffGrid
//
//  Created by Rachit Goyal on 7/4/26.
//

import SwiftUI

@main
struct OffGridApp: App {
    
    @State var theme: Theme = .init()
    var body: some Scene {
        WindowGroup {
            RootView()
                .applyTheme(theme)
                .environment(theme)
                .onAppear() {
                    theme.applyTheme(themeName: .limeDark)
                }
        }
    }
}
