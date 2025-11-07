//
//  IOSApp5App.swift
//  IOSApp5
//
//  Created by Jose Flores on 2025-11-07.
//

import SwiftUI
import FirebaseCore

@main
struct iOSApp5App: App {
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
