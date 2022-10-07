//
//  AuthenticationService.swift
//  Collie
//
//  Created by Pablo Penas on 03/10/22.
//

import Foundation
import FirebaseAuth

final class AuthenticationService {
    
    func createUser(email: String, password: String) {
        print("create")
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Error:", error.localizedDescription)
            }
            
            if let authResult = authResult {
                print("User id:", authResult.user.uid)
            }
        }
    }
}
