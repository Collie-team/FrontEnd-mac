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
    case managerOnboarding
    case employeeOnboarding
}

final class RootViewModel: ObservableObject {
    private let businessSubscriptionService = BusinessSubscriptionService()
    @Published var navigationState: NavigationState = .authentication
    
    
    var businessSelected: Business = Business(id: "", name: "", description: "", journeys: [], tasks: [], events: [])
    var currentUser: UserModel = UserModel(id: "", name: "", email: "", jobDescription: "", personalDescription: "", imageURL: "")
    var currentBusinessUser: BusinessUser?
    
    var authenticationToken: String?
    var availableBusiness: [Business] = []
    var availableBusinessUsers: [BusinessUser] = []
    
    func handleAuthentication(user: UserModel, authToken: String) -> () {
        self.authenticationToken = authToken
        self.currentUser = user
        businessSubscriptionService.fetchBusiness(user: self.currentUser, authenticationToken: self.authenticationToken!) { business, businessUser  in
            print(business)
            self.availableBusiness = business
            self.availableBusinessUsers = businessUser
            self.navigationState = .workspace
        }
    }
    
    func createWorkspace(workspaceName: String, _ completion: @escaping (Business) -> ()) {
        businessSubscriptionService.createBusiness(user: currentUser, businessName: workspaceName, authenticationToken: authenticationToken!) { business, businessUser  in
            self.currentBusinessUser = businessUser
            completion(business)
        }
    }
    
    func handleWorkspaceSelection(business: Business) {
        businessSelected = business
        if currentBusinessUser != nil {
            redirectBasedOnRole()
        } else {
            currentBusinessUser = availableBusinessUsers.first(where: {$0.businessId == business.id})
            redirectBasedOnRole()
        }
    }
    
    func redirectBasedOnRole() {
        if currentBusinessUser!.role == .admin || currentBusinessUser!.role == .manager {
            self.navigationState = .manager
        } else {
            self.navigationState = .employee
        }
    }
}
