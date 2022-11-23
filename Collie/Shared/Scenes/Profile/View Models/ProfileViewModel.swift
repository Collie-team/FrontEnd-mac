import Foundation
import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var editingMode: Bool = false
    @Published var showUserDeleteAlert: Bool = false
    
    private let authenticationService = AuthenticationService()
    
    func resetPassword(email: String, completion: @escaping () -> ()) {
        authenticationService.sendPasswordReset(withEmail: email) {
            completion()
        }
    }
}
