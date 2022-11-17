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
    @Published var image: NSImage?
    
    private let authenticationService = AuthenticationService()
    
    func resetPassword(email: String) {
        authenticationService.sendPasswordReset(withEmail: email)
    }
    
    func openFileSelection() {
        let openPanel = NSOpenPanel()
        openPanel.prompt = "Select File"
        openPanel.allowsMultipleSelection = false
        openPanel.canChooseDirectories = false
        openPanel.canCreateDirectories = false
        openPanel.canChooseFiles = true
        openPanel.allowedFileTypes = ["png","jpg","jpeg"]
        openPanel.begin { [self] (result) -> Void in
            if result.rawValue == NSApplication.ModalResponse.OK.rawValue {
                let selectedPath = openPanel.url!.path
                self.image = NSImage(contentsOf: URL(fileURLWithPath: selectedPath))!
            }
        }
    }
}
