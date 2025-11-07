//
//  StorageService.swift
//  IOSApp5
//
//  Created by Jose Flores on 2025-11-07.
//

import Foundation
import FirebaseStorage
import UIKit

final class StorageService {
    private let storage = Storage.storage()
    
    /// Sube una UIImage y devuelve la ruta remota (path).
    func uploadImage(_ image: UIImage, path: String, completion: @escaping (Result<String, Error>) -> Void) {
        let storageRef = storage.reference().child(path)
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            completion(.failure(NSError(domain:"", code:0, userInfo:[NSLocalizedDescriptionKey:"No se pudo convertir la imagen"])))
            return
        }
        let meta = StorageMetadata()
        meta.contentType = "image/jpeg"
        storageRef.putData(imageData, metadata: meta) { _, error in
            if let error = error { completion(.failure(error)); return }
            storageRef.downloadURL { url, err in
                if let err = err { completion(.failure(err)); return }
                if let url = url {
                    completion(.success(url.absoluteString))
                } else {
                    completion(.failure(NSError(domain:"", code:0, userInfo:[NSLocalizedDescriptionKey:"No URL devolvido"])))
                }
            }
        }
    }
}
