import SwiftUI
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
    private let firebaseStorageService = FirebaseStorageService()
    private let userSubscriptionService = UserSubscriptionService()
    private let businessSubscriptionService = BusinessSubscriptionService()
    private let businessUserSubscriptionService = BusinessUserSubscriptionService()
    @Published var navigationState: NavigationState = .authentication
    
    
    @Published var businessSelected: Business {
        didSet {
            print(businessSelected)
        }
    }
    
    @Published var currentUser: UserModel = UserModel(id: "", name: "", email: "", jobDescription: "", personalDescription: "", imageURL: "")
    var currentBusinessUser: BusinessUser?
    
    var authenticationToken: String?
    var availableBusiness: [Business] = []
    var availableBusinessUsers: [BusinessUser] = [] {
        didSet{
            
            print("root view buser:", availableBusinessUsers.map{$0.userId})
        }
    }
    
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
    
    func updateBusinessUser(_ businessUser: BusinessUser, _ completion: @escaping (BusinessUser) -> () = {_ in }) {
        businessUserSubscriptionService.updateBusinessUser(businessUser: businessUser, authenticationToken: "", { businessUserResponse in
            if self.currentBusinessUser!.userId == businessUser.userId {
                self.currentBusinessUser = businessUserResponse
            }
            completion(businessUser)
        })
    }
    
    func getCategory(categoryId: String) -> TaskCategory {
        if let category = businessSelected.categories.first(where: {$0.id == categoryId}) {
            return category
        } else {
            return TaskCategory(id: "", name: "Sem categoria", colorName: "", systemImageName: "")
        }
    }
    
    func updateUser(userData: UserModel) {
        userSubscriptionService.updateUser(authenticationToken: "", userData: userData) { userModel in
            self.currentUser = userModel
        }
    }
    
    func inviteUser(userToAdd: UserModel, role: BusinessUserRoles, _ completion: @escaping () -> ()) {
        let emailService = APISubscriptionService()
        emailService.sendInviteEmail(authenticationToken: "", business: businessSelected, email: userToAdd.email) {
            // Prompt success
            completion()
        }
    }
    
    func deleteUserData() {
        userSubscriptionService.eraseUserData(userId: currentUser.id, authenticationToken: "") {
            let user = Auth.auth().currentUser

            user?.delete { error in
              if let error = error {
                // An error happened.
                  print(error)
              } else {
                // Account deleted.
                  print("User deleted")
              }
            }
            self.navigationState = .authentication
        }
    }
    
    func openFileSelectionForProfileImage() {
        let openPanel = NSOpenPanel()
        openPanel.prompt = "Select File"
        openPanel.allowsMultipleSelection = false
        openPanel.canChooseDirectories = false
        openPanel.canCreateDirectories = false
        openPanel.canChooseFiles = true
        openPanel.allowedContentTypes = [.png, .jpeg]
        openPanel.begin { [self] (result) -> Void in
            if result.rawValue == NSApplication.ModalResponse.OK.rawValue {
                let selectedPath = openPanel.url!.path
                firebaseStorageService.uploadProfileImage(image: NSImage(contentsOf: URL(fileURLWithPath: selectedPath))!, userId: currentUser.id)
                firebaseStorageService.loadProfileImage(userId: currentUser.id) { url in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.currentUser.imageURL = url
                        self.updateUser(userData: self.currentUser)
                    }
                }
            }
        }
    }
    
    func openFileSelectionForJourneyImage(journeyId: String, _ completion: @escaping (Bool) -> ()) {
        let openPanel = NSOpenPanel()
        openPanel.prompt = "Select File"
        openPanel.allowsMultipleSelection = false
        openPanel.canChooseDirectories = false
        openPanel.canCreateDirectories = false
        openPanel.canChooseFiles = true
        openPanel.allowedContentTypes = [.png, .jpeg]
        openPanel.begin { [self] (result) -> Void in
            if result.rawValue == NSApplication.ModalResponse.OK.rawValue {
                completion(true)
                let selectedPath = openPanel.url!.path
                firebaseStorageService.uploadJourneyImage(image: NSImage(contentsOf: URL(fileURLWithPath: selectedPath))!, journeyId: journeyId)
                firebaseStorageService.loadJourneyImage(journeyId: journeyId) { url in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.businessSelected.journeys = self.businessSelected.journeys.map { (businessJourney: Journey) -> Journey in
                            if businessJourney.id == journeyId {
                                var responseJourney = businessJourney
                                responseJourney.imageURL = url
                                return responseJourney
                            } else {
                                return businessJourney
                            }
                        }
                        self.updateBusiness(self.businessSelected, replaceBusiness: false)
                    }
                }
            } else {
                completion(false)
            }
        }
    }
}
