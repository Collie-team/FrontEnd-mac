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
//    @Published var currentUser = AuthenticationUser()
    @Published var currentUser = AuthenticationUser(firstName: "Teste", lastName: "Backend", email: "backend@teste.com", password: "Backend123", passwordConfirmation: "Backend123", agreementToggle: true, mailingToggle: false)
    @Published var signupEnabled = false
    @Published var loginEnabled = false
    @Published var authenticationStatus: AuthenticationStatus = .valid
    
    private let authenticationService = AuthenticationService()
    private let databaseService = DatabaseSubscriptionService<UserModel>(route: .user)
    
    func resetUser() {
//        currentUser = AuthenticationUser()
    }
    
    func validateSingUpFields() {
        signupEnabled = currentUser.validateSignup()
        print(signupEnabled)
    }
    
    func validateLoginFields() {
        loginEnabled = currentUser.validateLogin()
    }
    
    func createUser() {
        authenticationService.createUser(email: currentUser.email, password: currentUser.password) { status, user, token in
            self.authenticationStatus = status
            if let user = user, let token = token {
                // TODO: Save user to variable
                let userData = UserModel(id: user.uid, name: self.currentUser.firstName + self.currentUser.lastName, email: self.currentUser.email, jobDescription: "", personalDescription: "", imageURL: "", businessId: "")
                self.databaseService.writeData(dataToWrite: userData, authenticationToken: token) { writtenData in
                    print(writtenData)
//                    self.currentUser = writtenData
                }
            }
        }
    }
    
    func loginUser() {
        authenticationService.loginUser(email: currentUser.email, password: currentUser.password) { status, user, token in
            self.authenticationStatus = status
            if let user = user, let token = token {
                // TODO: Save user to variable
                self.databaseService.fetchData(authenticationToken: token) { userData in
                    print(userData)
                }
            }
        }
    }
    
    func resetPassword() {
        authenticationService.sendPasswordReset(withEmail: currentUser.email)
    }
}
