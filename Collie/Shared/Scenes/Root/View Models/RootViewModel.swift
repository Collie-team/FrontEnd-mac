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
    
    
    @Published var businessSelected: Business {
        didSet {
            print(businessSelected)
        }
    }
    
    var currentUser: UserModel = UserModel(id: "", name: "", email: "", jobDescription: "", personalDescription: "", imageURL: "")
    var currentBusinessUser: BusinessUser?
    
    var authenticationToken: String?
    var availableBusiness: [Business] = []
    var availableBusinessUsers: [BusinessUser] = []
    
    init() {
        self.businessSelected = Business(id: "", name: "", description: "", journeys: [], tasks: [], categories: [], events: [])
    }
    
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
            let isManagerOnboardingDone = OnboardingStorageService.shared.isOnboardingDone(onboardingType: .businessManager)
            if isManagerOnboardingDone {
                self.navigationState = .manager
            } else {
                self.navigationState = .managerOnboarding
            }
        } else {
            let isEmployeeOnboardingDone = OnboardingStorageService.shared.isOnboardingDone(onboardingType: .employee)
            if isEmployeeOnboardingDone {
                self.navigationState = .employee
            } else {
                self.navigationState = .employeeOnboarding
            }
        }
    }
    
    func updateBusiness(_ business: Business, replaceBusiness: Bool) {
        businessSubscriptionService.updateBusiness(overwrite: replaceBusiness, authenticationToken: "", business: business) { businessUpdated in
            self.businessSelected = businessUpdated
            self.objectWillChange.send()
        }
    }
    
    func refreshBusiness() {
        businessSubscriptionService.refreshBusiness(authenticationToken: "", businessId: businessSelected.id) { business in
            self.businessSelected = business
            self.objectWillChange.send()
        }
    }
    
    func updateBusinessUser(_ businessUser: BusinessUser) {
        businessUserSubscriptionService.updateBusinessUser(businessUser: businessUser, authenticationToken: "", { businessUser in
            self.currentBusinessUser = businessUser
        })
    }
    
    func getCategory(categoryId: String) -> TaskCategory {
        return businessSelected.categories.first(where: {$0.id == categoryId}) ?? .init(id: "", name: "Sem categoria", colorName: "", systemImageName: "")
    }
}
