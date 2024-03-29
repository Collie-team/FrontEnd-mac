import SwiftUI
import FirebaseAuth
import Firebase

enum NavigationState {
    case loading
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
    
    @Published var navigationState: NavigationState = .loading
    
    @Published var businessSelected: Business {
        didSet {
            print(businessSelected)
        }
    }
    
    @Published var currentUser: UserModel = UserModel(id: "", name: "", email: "", jobDescription: "", personalDescription: "", imageURL: "")
    
    @Published var inspectingJourney: Journey?
    @Published var inspectingBusinessUser: BusinessUser?
    @Published var inspectingUser: UserModel?
    @Published var loadingInspection: Bool = false
    
    var currentBusinessUser: BusinessUser?
    
    var authenticationToken: String?
    
    var availableBusinesses: [Business] = []
    var availableBusinessUsers: [BusinessUser] = [] {
        didSet{
            print("root view buser:", availableBusinessUsers.map{$0.userId})
        }
    }
    
    var authStateDidChangeListenerHandle: AuthStateDidChangeListenerHandle?
    
    init() {
        self.businessSelected = Business(id: "", name: "", description: "", journeys: [], tasks: [], categories: [], events: [])
    }
    
    func checkIfUserIsLoggedIn() {
        print("Checking log in")
        if let user = Auth.auth().currentUser {
            user.getIDTokenForcingRefresh(false) { token, error in
                if let token = token {
                    print("Fetching user")
                    self.userSubscriptionService.fetchUser(authenticationToken: token) { userModel in
                        self.handleAuthentication(user: userModel, authToken: token)
                    }
                }
            }
        } else {
            self.navigationState = .authentication
        }
    }
    
    func fetchAvailableBusinesses(completion: @escaping () -> ()) {
        businessSubscriptionService.fetchBusiness(user: self.currentUser, authenticationToken: self.authenticationToken!) { business, businessUser  in
            print(business)
            self.availableBusinesses = business
            self.availableBusinessUsers = businessUser
            self.navigationState = .workspace
            completion()
        }
    }
    
    func handleAuthentication(user: UserModel, authToken: String) -> () {
        self.authenticationToken = authToken
        self.currentUser = user
        self.fetchAvailableBusinesses{}
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
    
    func exitCurrentWorkspace() {
        navigationState = .workspace
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.currentBusinessUser = nil
        })
    }
    
    func exitUserAccount() {
        do {
            try Auth.auth().signOut()
            navigationState = .authentication
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                self.currentBusinessUser = nil
            })
        } catch {
            print("Error while signing out!")
        }
    }
    
    func openFileSelectionForProfileImage() {
        let openPanel = NSOpenPanel()
        openPanel.prompt = "Escolha uma imagem"
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
    
    func openFileSelectionForJourneyImage(journeyId: String, _ completion: @escaping (Bool) -> () = {_ in }) {
        let openPanel = NSOpenPanel()
        openPanel.prompt = "Escolha uma imagem"
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
    
    func openFileSelectionForBusinessImage() {
        let openPanel = NSOpenPanel()
        openPanel.prompt = "Escolha uma imagem"
        openPanel.allowsMultipleSelection = false
        openPanel.canChooseDirectories = false
        openPanel.canCreateDirectories = false
        openPanel.canChooseFiles = true
        openPanel.allowedContentTypes = [.png, .jpeg]
        openPanel.begin { [self] (result) -> Void in
            if result.rawValue == NSApplication.ModalResponse.OK.rawValue {
                let selectedPath = openPanel.url!.path
                firebaseStorageService.uploadBusinessImage(image: NSImage(contentsOf: URL(fileURLWithPath: selectedPath))!, businessId: businessSelected.id)
                firebaseStorageService.loadBusinessImage(businessId: businessSelected.id) { url in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.businessSelected.imageURL = url
                        self.updateBusiness(self.businessSelected, replaceBusiness: false)
                    }
                }
            }
        }
    }
    
    func configureEmployeeInspection(userId: String, journeyId: String, _ completion: @escaping () -> ()) {
        loadingInspection = true
        if journeyId != "" {
            self.inspectingJourney = businessSelected.journeys.filter({$0.id == journeyId}).first
        }
        businessUserSubscriptionService.fetchBusinessUser(userId: userId, businessId: businessSelected.id, authenticationToken: "") { busUser, user in
            self.inspectingBusinessUser = busUser
            self.inspectingUser = user
            completion()
            self.loadingInspection = false
        }
    }
}
