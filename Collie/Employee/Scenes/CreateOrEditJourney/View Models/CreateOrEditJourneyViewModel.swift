import Foundation

final class CreateNewJourneyViewModel: ObservableObject {
    private let teamListService = TeamSubscriptionService()
    private let businessSubscriptionService = BusinessSubscriptionService()
    
    @Published var journeyId: String = UUID().uuidString
    
    @Published var journeyName: String = ""
    
    @Published var journeyDescription: String = ""
    
    @Published var showUsersList = false
    
    @Published var chosenUserModels: [UserModel] = []
    
    @Published var userModelList: [UserModel] = []
    
    @Published var startDate: Date = Date()
    
    var currentBusiness: Business
    
    var userId: String
    
    init(userId: String, currentBusiness: Business) {
        self.userId = userId
        self.currentBusiness = currentBusiness
    }
    
    func fetchUsers(business: Business) {
        currentBusiness = business
        teamListService.fetchTeamInfo(business: business, authenticationToken: "TO DO") { businessUsers, userModels in
            self.userModelList = userModels.filter({ $0.id != self.userId})
            
            // Load chosen user Models
            self.fetchOldUsersOnJourney()
        }
    }
    
    func fetchOldUsersOnJourney() {
        self.chosenUserModels = userModelList.filter({ user in
            if let journey = currentBusiness.journeys.first(where: {$0.id == self.journeyId}) {
                let isUserOnJourney = journey.userIds.contains(user.id)
                return isUserOnJourney
            } else {
                return false
            }
        })
        self.userModelList = userModelList.filter({ userModel in
            !chosenUserModels.contains(userModel)
        })
        objectWillChange.send()
    }
    
    func isButtonDisabled() -> Bool {
        journeyName == ""
    }
    
    func selectUserModel(_ userModel: UserModel) {
        if !chosenUserModels.contains(userModel) {
            chosenUserModels.append(userModel)
            
            if let index = userModelList.firstIndex(of: userModel) {
                userModelList.remove(at: index)
            }
            objectWillChange.send()
        }
    }
    
    func removeUserModel(_ userModel: UserModel) {
        if let index = chosenUserModels.firstIndex(of: userModel) {
            chosenUserModels.remove(at: index)
            userModelList.append(userModel)
        }
    }
    
    func handleJourneySave(completion: (Business, Journey) -> ()) {
        var updatedBusiness = currentBusiness
        
        let journey = Journey(
            id: journeyId,
            name: journeyName,
            description: journeyDescription,
            imageURL: "",
            startDate: startDate,
            userIds: chosenUserModels.map({$0.id})
        )
        
        if let journeyIndex = updatedBusiness.journeys.firstIndex(where: {$0.id == journeyId}) {
            updatedBusiness.journeys[journeyIndex] = journey
        } else {
            updatedBusiness.journeys.append(journey)
        }
        
        completion(updatedBusiness, journey)
    }
}
