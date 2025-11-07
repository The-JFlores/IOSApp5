//
//  RegisterView.swift
//  IOSApp5
//
//  Created by Jose Flores on 2025-11-07.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var auth: AuthService
    @Environment(\.dismiss) var dismiss
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage: String?
    
    var body: some View {
        NavigationView {
            VStack(spacing: 12) {
                TextField("Email", text: $email)
                    .autocapitalization(.none)
                    .textContentType(.emailAddress)
                SecureField("Password", text: $password)
                if let m = errorMessage { Text(m).foregroundColor(.red).font(.caption) }
                Button("Crear") {
                    auth.register(email: email, password: password) { result in
                        switch result {
                        case .success: dismiss()
                        case .failure(let err): errorMessage = err.localizedDescription
                        }
                    }
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
            .navigationTitle("Crear cuenta")
        }
    }
}

#Preview {
    RegisterView()
}
