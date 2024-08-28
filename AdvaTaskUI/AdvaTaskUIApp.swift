//
//  AdvaTaskUIApp.swift
//  AdvaTaskUI
//
//  Created by Mahmoud on 28/08/2024.
//

import SwiftUI

@main
struct AdvaTaskUIApp: App {
    var body: some Scene {
        WindowGroup {
            PhotoListView()
                .environmentObject(PhotoListViewModel()) // Ensure you provide any necessary environment objects here
        }
    }
}
