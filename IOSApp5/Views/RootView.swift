//
//  RootView.swift
//  IOSApp5
//
//  Created by Jose Flores on 2025-11-07.
//

import SwiftUI

struct RootView: View {
    @StateObject var auth = AuthService()
    
    var body: some View {
        Group {
            if auth.user != nil {
                MainListView()
                    .environmentObject(auth)
            } else {
                LoginView()
                    .environmentObject(auth)
            }
        }
    }
}
#Preview {
    RootView()
}
