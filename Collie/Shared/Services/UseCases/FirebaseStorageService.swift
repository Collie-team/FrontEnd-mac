//
//  FirebaseStorageService.swift
//  Collie
//
//  Created by Pablo Penas on 17/11/22.
//

import SwiftUI
import Firebase
import FirebaseStorage

final class FirebaseStorageService {
    let storage = Storage.storage()
    
    func uploadProfileImage(image: NSImage, userId: String) {
        // Create a storage reference
        let storageRef = storage.reference().child("profilePictures/\(userId).jpg")
        
        // Resize the image to 200px with a custom extension
        //        let resizedImage = image.aspectFittedToHeight(200)
        
        // Convert the image into JPEG and compress the quality to reduce its size
        let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil)!
        let bitmapRep = NSBitmapImageRep(cgImage: cgImage)
        let jpegData = bitmapRep.representation(using: NSBitmapImageRep.FileType.jpeg, properties: [:])!
        
        // Change the content type to jpg. If you don't, it'll be saved as application/octet-stream type
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        // Upload the image
        storageRef.putData(jpegData, metadata: metadata) { (metadata, error) in
            if let error = error {
                print("Error while uploading file: ", error)
            }
            
            if let metadata = metadata {
                print("Metadata: ", metadata)
            }
        }
        
    }
    
    func loadProfileImage(userId: String, _ completion: @escaping (String) -> ()) {
        let path = "profilePictures/\(userId).jpg"
        let storageRef = storage.reference().child(path)
        storageRef.downloadURL(completion: { url, error in
            guard let url = url, error == nil else {
                return
            }
            completion(url.absoluteString)
        })
    }
    
    func uploadJourneyImage(image: NSImage, journeyId: String) {
        let storageRef = storage.reference().child("journeyImages/\(journeyId).jpg")
        
        // Convert the image into JPEG and compress the quality to reduce its size
        let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil)!
        let bitmapRep = NSBitmapImageRep(cgImage: cgImage)
        let jpegData = bitmapRep.representation(using: NSBitmapImageRep.FileType.jpeg, properties: [:])!
        
        // Change the content type to jpg. If you don't, it'll be saved as application/octet-stream type
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        // Upload the image
        storageRef.putData(jpegData, metadata: metadata) { (metadata, error) in
            if let error = error {
                print("Error while uploading file: ", error)
            }
            
            if let metadata = metadata {
                print("Metadata: ", metadata)
            }
        }
    }
    
    func loadJourneyImage(journeyId: String, _ completion: @escaping (String) -> ()) {
        let path = "journeyImages/\(journeyId).jpg"
        let storageRef = storage.reference().child(path)
        storageRef.downloadURL(completion: { url, error in
            guard let url = url, error == nil else {
                return
            }
            completion(url.absoluteString)
        })
    }
}
