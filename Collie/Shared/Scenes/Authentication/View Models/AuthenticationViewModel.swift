import SwiftUI

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
    private let userSubscriptionService = UserSubscriptionService()
    
    func validateSingUpFields() {
        signupEnabled = currentUser.validateSignup()
        print(signupEnabled)
    }
    
    func validateLoginFields() {
        loginEnabled = currentUser.validateLogin()
    }
    
    func createUser(_ completion: @escaping (UserModel, String) -> ()) {
        authenticationService.createUser(email: currentUser.email, password: currentUser.password) { status, user, token in
            self.authenticationStatus = status
            if let user = user, let token = token {
                let userData = UserModel(id: user.uid, name: self.currentUser.firstName + " " + self.currentUser.lastName, email: self.currentUser.email, jobDescription: "", personalDescription: "", imageURL: "")
                self.userSubscriptionService.createUser(user: userData, authenticationToken: token) { writtenData in
                    completion(writtenData, token)
                }
            }
        }
    }
    
    func loginUser(_ completion: @escaping (UserModel, String) -> ()) {
        authenticationService.loginUser(email: currentUser.email, password: currentUser.password) { status, user, token in
            self.authenticationStatus = status
            if let _ = user, let token = token {
                self.userSubscriptionService.fetchUser(authenticationToken: token) { userData in
                    completion(userData, token)
                    print(userData)
                }
            }
        }
    }
    
    func resetPassword(completion: @escaping () -> ()) {
        authenticationService.sendPasswordReset(withEmail: currentUser.email) {
            completion()
        }
    }
}
