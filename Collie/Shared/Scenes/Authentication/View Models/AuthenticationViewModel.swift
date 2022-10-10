//
//  AuthenticationViewModel.swift
//  Collie
//
//  Created by Pablo Penas on 05/10/22.
//

import SwiftUI

struct AuthenticationUser: Equatable {
    var firstName: String = ""
    var lastName: String = ""
    var email: String = ""
    var password: String = ""
    var passwordConfirmation: String = ""
    var agreementToggle: Bool = false
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
}

class AuthenticationViewModel: ObservableObject {
    @Published var authenticationMode: AuthenticationMode = .signup
    @Published var currentUser = AuthenticationUser()
    @Published var signupEnabled = false
    @Published var loginEnabled = false
    @Published var authenticationStatus: AuthenticationStatus = .valid
    
    private let authenticationService = AuthenticationService()
    
    func resetUser() {
        currentUser = AuthenticationUser()
    }
    
    func validateSingUpFields() {
        signupEnabled = currentUser.validateSignup()
        print(signupEnabled)
    }
    
    func validateLoginFields() {
        loginEnabled = currentUser.validateLogin()
    }
    
    func createUser() {
        authenticationService.createUser(email: currentUser.email, password: currentUser.password) { user, status in
            self.authenticationStatus = status
            // TODO: Save user to variable
        }
    }
    
    func loginUser() {
        authenticationService.loginUser(email: currentUser.email, password: currentUser.password) { user, status in
            self.authenticationStatus = status
            // TODO: Save user to variable
        }
    }
    
    func resetPassword() {
        authenticationService.sendPasswordReset(withEmail: currentUser.email)
    }
}
