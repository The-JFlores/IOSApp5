//
//  LoginView.swift
//  IOSApp5
//
//  Created by Jose Flores on 2025-11-07.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var auth: AuthService
    @State private var email = ""
    @State private var password = ""
    @State private var showingRegister = false
    @State private var errorMessage: String?
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                TextField("Email", text: $email)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding()
                    .background(.secondary.opacity(0.1))
                    .cornerRadius(8)
                SecureField("Password", text: $password)
                    .padding()
                    .background(.secondary.opacity(0.1))
                    .cornerRadius(8)
                
                if let errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                }
                
                Button("Iniciar sesión") {
                    auth.signIn(email: email, password: password) { result in
                        switch result {
                        case .success: break
                        case .failure(let err): errorMessage = err.localizedDescription
                        }
                    }
                }
                .buttonStyle(.borderedProminent)
                
                Button("Crear cuenta") { showingRegister.toggle() }
                    .sheet(isPresented: $showingRegister) {
                        RegisterView()
                            .environmentObject(auth)
                    }
            }
            .padding()
            .navigationTitle("iOSApp5")
        }
    }
}

#Preview {
    LoginView()
}
