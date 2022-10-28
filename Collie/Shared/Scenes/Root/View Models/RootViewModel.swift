//
//  RootViewModel.swift
//  Collie
//
//  Created by Pablo Penas on 18/10/22.
//

import SwiftUI

enum NavigationState {
    case authentication
    case workspace
    case manager
    case employee
}

final class RootViewModel: ObservableObject {
    @Published var navigationState: NavigationState = .authentication
    var businessSelected: Business = Business(id: "", name: "", description: "", journeys: [], tasks: [], events: [])
    
    private let businessSubscriptionService = BusinessSubscriptionService()
    
    var currentUser: UserModel = UserModel(id: "", name: "", email: "", jobDescription: "", personalDescription: "", imageURL: "")
    var authenticationToken: String?
    var availableBusiness: [Business] = []
    
    func handleAuthentication(user: UserModel, authToken: String) -> () {
        self.authenticationToken = authToken
        self.currentUser = user
        businessSubscriptionService.fetchBusiness(user: self.currentUser, authenticationToken: self.authenticationToken!) { businessData in
            print(businessData)
            self.availableBusiness = businessData
            self.navigationState = .workspace
        }
    }
    
    func createWorkspace(workspaceName: String, _ completion: @escaping ([Business]) -> ()) {
        businessSubscriptionService.createBusiness(user: currentUser, businessName: workspaceName, authenticationToken: authenticationToken!) { user, userBusiness in
            self.currentUser = user
            self.availableBusiness = userBusiness
            completion(self.availableBusiness)
        }
    }
    
    func handleWorkspaceSelection(business: Business) {
        // GAMBIARRA MASTER WARNING
        print("USERNAME: \(currentUser.name)")
        businessSelected = business
        if currentUser.name.localizedCaseInsensitiveContains("GESTOR") {
            self.navigationState = .manager
        } else {
            self.navigationState = .employee
        }
    }
}
