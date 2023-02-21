//
//  SetApp.swift
//  Set
//
//  Created by Hamish Young on 9/2/2023.
//

import SwiftUI

@main
struct SetApp: App {
    var body: some Scene {
        WindowGroup {
            let viewModel = ContentView.SetViewModel()
            ContentView(viewModel: viewModel)
        }
    }
}
