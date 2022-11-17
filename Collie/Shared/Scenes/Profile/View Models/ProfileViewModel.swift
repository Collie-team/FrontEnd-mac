//
//  ProfileViewModel.swift
//  Collie
//
//  Created by Pablo Penas on 17/11/22.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var editingMode: Bool = false
    
    private let authenticationService = AuthenticationService()
    
    func resetPassword(email: String) {
        authenticationService.sendPasswordReset(withEmail: email)
    }
}
