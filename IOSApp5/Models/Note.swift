//
//  Note.swift
//  IOSApp5
//
//  Created by Jose Flores on 2025-11-07.
//

import Foundation
import FirebaseFirestoreSwift

struct Note: Identifiable, Codable {
    @DocumentID var id: String?     // Firestore document id
    var title: String
    var body: String
    var imagePath: String?         // path in Firebase Storage
    var createdAt: Date?
    
    init(id: String? = nil, title: String = "", body: String = "", imagePath: String? = nil, createdAt: Date? = Date()) {
        self.id = id
        self.title = title
        self.body = body
        self.imagePath = imagePath
        self.createdAt = createdAt
    }
}
