import SwiftUI
import FirebaseAuth
import Firebase

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
    private let businessUserSubscriptionService = BusinessUserSubscriptionService()
    private let userSubscriptionService = UserSubscriptionService()
    
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
    
    var authStateDidChangeListenerHandle: AuthStateDidChangeListenerHandle?
    
    init() {
        self.businessSelected = Business(id: "", name: "", description: "", journeys: [], tasks: [], categories: [], events: [])
    }
    
    func configureFirebaseStateDidChange() {
        self.authStateDidChangeListenerHandle = Auth.auth().addStateDidChangeListener({ auth, user in
            if let authUser = Auth.auth().currentUser {
                authUser.getIDTokenForcingRefresh(true) { idToken, error in
                    if let error = error {
                        print(error.localizedDescription)
                    }
                    
                    if let token = idToken {
                        self.userSubscriptionService.fetchUser(authenticationToken: token) { userModel in
                            self.handleAuthentication(user: userModel, authToken: token)
                        }
                    }
                }
            } else {
                self.navigationState = .authentication
            }
        })
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
        self.businessSelected = business
        
        if self.currentBusinessUser != nil {
            self.redirectBasedOnRole()
        } else {
            self.currentBusinessUser = self.availableBusinessUsers.first(where: {$0.businessId == business.id})
            self.redirectBasedOnRole()
        }
        self.objectWillChange.send()
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
        }
    }
    
    func updateBusinessUser(_ businessUser: BusinessUser) {
        businessUserSubscriptionService.updateBusinessUser(businessUser: businessUser, authenticationToken: "", { businessUser in
            self.currentBusinessUser = businessUser
        })
    }
    
    func getCategory(categoryId: String) -> TaskCategory {
        if let category = businessSelected.categories.first(where: {$0.id == categoryId}) {
            return category
        } else {
            return TaskCategory(id: "", name: "Sem categoria", colorName: "", systemImageName: "")
        }
    }
}
