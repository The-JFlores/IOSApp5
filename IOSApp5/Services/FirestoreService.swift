//
//  FirestoreService.swift
//  IOSApp5
//
//  Created by Jose Flores on 2025-11-07.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

final class FirestoreService: ObservableObject {
    private let db = Firestore.firestore()
    @Published var notes: [Note] = []
    private var listener: ListenerRegistration?
    
    init() {
        // Observa la colección "notes" ordenada por fecha
        listener = db.collection("notes")
            .order(by: "createdAt", descending: true)
            .addSnapshotListener { [weak self] snapshot, error in
                if let error = error {
                    print("Error escuchando notas: \(error)")
                    return
                }
                self?.notes = snapshot?.documents.compactMap { doc in
                    try? doc.data(as: Note.self)
                } ?? []
            }
    }
    
    deinit {
        listener?.remove()
    }
    
    func add(_ note: Note, completion: ((Error?) -> Void)? = nil) {
        do {
            var n = note
            n.createdAt = Date()
            _ = try db.collection("notes").addDocument(from: n, completion: completion)
        } catch {
            completion?(error)
        }
    }
    
    func update(_ note: Note, completion: ((Error?) -> Void)? = nil) {
        guard let id = note.id else { completion?(NSError(domain:"", code:0, userInfo:[NSLocalizedDescriptionKey:"No ID"])); return }
        do {
            try db.collection("notes").document(id).setData(from: note, merge: true, completion: completion)
        } catch {
            completion?(error)
        }
    }
    
    func delete(_ note: Note, completion: ((Error?) -> Void)? = nil) {
        guard let id = note.id else { completion?(NSError(domain:"", code:0, userInfo:[NSLocalizedDescriptionKey:"No ID"])); return }
        db.collection("notes").document(id).delete(completion: completion)
    }
}
