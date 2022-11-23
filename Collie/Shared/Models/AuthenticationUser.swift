import Foundation

struct AuthenticationUser: Equatable {
    var firstName: String = "André"
    var lastName: String = "Arns"
    var email: String = "andre@collie.work"
    var password: String = "Aa1234567!"
    var passwordConfirmation: String = "Aa1234567!"
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
