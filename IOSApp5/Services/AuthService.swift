//
//  AuthService.swift
//  IOSApp5
//
//  Created by Jose Flores on 2025-11-07.
//

import Foundation
import FirebaseAuth
import Combine

final class AuthService: ObservableObject {
    @Published var user: User? = Auth.auth().currentUser
    private var handle: AuthStateDidChangeListenerHandle?
    
    init() {
        handle = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            self?.user = user
        }
    }
    
    deinit {
        if let h = handle { Auth.auth().removeStateDidChangeListener(h) }
    }
    
    func signIn(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { res, err in
            if let err = err { completion(.failure(err)); return }
            if let user = res?.user { completion(.success(user)) }
        }
    }
    
    func register(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { res, err in
            if let err = err { completion(.failure(err)); return }
            if let user = res?.user { completion(.success(user)) }
        }
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
        self.user = nil
    }
}
