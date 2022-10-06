//
//  AuthenticationViewModel.swift
//  Collie
//
//  Created by Pablo Penas on 05/10/22.
//

import SwiftUI

struct AuthenticationUser {
    var firstName: String = ""
    var lastName: String = ""
    var email: String = ""
    var password: String = ""
    var passwordConfirmation: String = ""
    var agreementToggle: Bool = false
    var mailingToggle: Bool = false
}

enum AuthenticationMode {
    case signup
    case login
}

class AuthenticationViewModel: ObservableObject {
    @Published var authenticationMode: AuthenticationMode = .signup
    @Published var currentUser = AuthenticationUser()
}
