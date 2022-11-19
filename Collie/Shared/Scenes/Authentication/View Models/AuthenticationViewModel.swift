//
//  AuthenticationViewModel.swift
//  Collie
//
//  Created by Pablo Penas on 05/10/22.
//

import SwiftUI

struct AuthenticationUser: Equatable {
//    var firstName: String = "André"
//    var lastName: String = "Arns"
//    var email: String = "andre@collie.work"
//    var password: String = "Aa1234567!"
//    var passwordConfirmation: String = "Aa1234567!"
//    var agreementToggle: Bool = true
//    var mailingToggle: Bool = false
    var firstName: String = ""
    var lastName: String = ""
    var email: String = ""
    var password: String = ""
    var passwordConfirmation: String = ""
    var agreementToggle: Bool = true
    var mailingToggle: Bool = false
    
    func isValidEmail() -> Bool {
        // Minimum 8 characters at least 1 Uppercase Alphabet, 1 Lowercase Alphabet and 1 Number
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format:"SELF MATCHES %@", emailRegEx).evaluate(with: email)
    }
    
    func isValidPassword() -> Bool {
        let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{6,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }
    
    func validateSignup() -> Bool {
        return (
            self.firstName != "" && self.lastName != "" && self.isValidEmail() && self.agreementToggle && self.isValidPassword() && self.password == self.passwordConfirmation
        )
    }
    
    func validateLogin() -> Bool {
        return (
            self.isValidEmail() && self.password != ""
        )
    }
}

enum AuthenticationMode {
    case signup
    case login
    case passwordReset
    
    enum LoadingState {
        case waiting
        case authenticating
        case fetchingData
    }
}

class AuthenticationViewModel: ObservableObject {
    @Published var authenticationMode: AuthenticationMode = .signup
    @Published var currentUser = AuthenticationUser()
    @Published var signupEnabled = false
    @Published var loginEnabled = false
    @Published var authenticationStatus: AuthenticationStatus = .valid
    @Published var loadingState = AuthenticationMode.LoadingState.waiting
    
    private let authenticationService = AuthenticationService()
    private let userSubscriptionService = UserSubscriptionService()
    
    func resetUser() {
        //        currentUser = AuthenticationUser()
    }
    
    func validateSingUpFields() {
        signupEnabled = currentUser.validateSignup()
    }
    
    func validateLoginFields() {
        loginEnabled = currentUser.validateLogin()
    }
    
    func createUser(_ completion: @escaping (UserModel, String) -> ()) {
        loadingState = .authenticating
        authenticationService.createUser(email: currentUser.email, password: currentUser.password) { status, user, token in
            self.authenticationStatus = status
            self.loadingState = .fetchingData
            if let user = user, let token = token {
                let userData = UserModel(id: user.uid, name: self.currentUser.firstName + " " + self.currentUser.lastName, email: self.currentUser.email, jobDescription: "", personalDescription: "", imageURL: "")
                self.userSubscriptionService.createUser(user: userData, authenticationToken: token) { writtenData in
                    completion(writtenData, token)
                }
            }
        }
    }
    
    func loginUser(_ completion: @escaping (UserModel, String) -> ()) {
        loadingState = .authenticating
        authenticationService.loginUser(email: currentUser.email, password: currentUser.password) { status, user, token in
            self.authenticationStatus = status
            self.loadingState = .fetchingData
            if let _ = user, let token = token {
                self.userSubscriptionService.fetchUser(authenticationToken: token) { userData in
                    completion(userData, token)
                    print(userData)
                }
            }
        }
    }
    
    func resetPassword() {
        authenticationService.sendPasswordReset(withEmail: currentUser.email)
    }
}
