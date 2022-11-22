//
//  ProfileViewModel.swift
//  Collie
//
//  Created by Pablo Penas on 17/11/22.
//

import Foundation
import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var editingMode: Bool = false
    @Published var showUserDeleteAlert: Bool = false
    
    private let authenticationService = AuthenticationService()
    
    func resetPassword(email: String) {
        authenticationService.sendPasswordReset(withEmail: email)
    }
    
}
