//
//  AuthenticationService.swift
//  Collie
//
//  Created by Pablo Penas on 03/10/22.
//

import Foundation
import FirebaseAuth

enum AuthenticationStatus {
    case valid
    case emailInUse
    case invalidPassword
    case errorNotRegistered
}

final class AuthenticationService {
    
    func createUser(email: String, password: String, _ completion: @escaping (User?, AuthenticationStatus) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error as? NSError {
                print(error)
                switch AuthErrorCode(_nsError: error).code {
                case .operationNotAllowed:
                    // Error: The given sign-in provider is disabled for this Firebase project. Enable it in the Firebase console, under the sign-in method tab of the Auth section.
                    completion(nil, .errorNotRegistered)
                case .emailAlreadyInUse:
                    // Error: The email address is already in use by another account.
                    completion(nil, .emailInUse)
//                    response = AuthenticationResponse(status: .emailInUse, user: nil)
                case .invalidEmail:
                    // Error: The email address is badly formatted.
                    completion(nil, .errorNotRegistered)
                case .weakPassword:
                    // Error: The password must be 6 characters long or more.
                    completion(nil, .errorNotRegistered)
                default:
                    print("Error: \(error.localizedDescription)")
                }
            } else {
                completion(authResult?.user, .valid)
            }
        }
    }
    
    func loginUser(email: String, password: String, _ completion: @escaping (User?, AuthenticationStatus) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if let error = error as? NSError {
                switch AuthErrorCode(_nsError: error).code {
                case .operationNotAllowed:
                    // Error: Indicates that email and password accounts are not enabled. Enable them in the Auth section of the Firebase console.
                    completion(nil, .errorNotRegistered)
                case .userDisabled:
                    // Error: The user account has been disabled by an administrator.
                    completion(nil, .errorNotRegistered)
                case .wrongPassword:
                    // Error: The password is invalid or the user does not have a password.
                    completion(nil, .invalidPassword)
                case .invalidEmail:
                    // Error: Indicates the email address is malformed.
                    completion(nil, .invalidPassword)
                default:
                    print("Error: \(error.localizedDescription)")
                }
            } else {
                completion(authResult?.user, .valid)
            }
        }
    }
    
    func sendPasswordReset(withEmail email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if error == nil {
                // Email sent
                print("Email sent")
            }
        }
    }
}
