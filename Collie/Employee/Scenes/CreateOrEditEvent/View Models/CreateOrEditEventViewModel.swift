import Foundation

final class CreateOrEditEventViewModel: ObservableObject {
    private let teamListService = TeamSubscriptionService()
    
    var eventId: String?
    
    @Published var eventName = ""
    
    @Published var startDate = Date()
    
    @Published var endDate = Date()
    
    @Published var eventLink = ""
    
    @Published var eventDescription = ""
    
    @Published var selectedCategory: TaskCategory?
    
    @Published var showUserList = false
    
    @Published var showCategoryList = false
    
    @Published var categoryList: [TaskCategory] = []
    
    @Published var userModelList: [UserModel] = []
    
    @Published var chosenUserModels: [UserModel] = []
    
    var currentBusiness: Business?
    
    init(categoryList: [TaskCategory]) {
        self.categoryList = categoryList
    }
    
    func fetchUsers(business: Business) {
        currentBusiness = business
        teamListService.fetchTeamInfo(business: business, authenticationToken: "TO DO") { businessUsers, userModels in
            self.userModelList = userModels
            
            // Load chosen user Models
            self.fetchOldUsersOnEvent()
        }
    }
    
    func fetchOldUsersOnEvent() {
        self.chosenUserModels = userModelList.filter({ user in
            if let journey = currentBusiness!.journeys.first(where: {$0.id == self.eventId}) {
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
        eventName.isEmpty
    }
    
    func selectUserModel(_ userModel: UserModel) {
        chosenUserModels.append(userModel)
        if let index = userModelList.firstIndex(where: { $0.id == userModel.id }) {
            userModelList.remove(at: index)
        }
    }
    
    func removeUserModel(_ userModel: UserModel) {
        if let index = chosenUserModels.firstIndex(where: { $0.id == userModel.id }) {
            chosenUserModels.remove(at: index)
            userModelList.append(userModel)
        }
    }
    
    func selectCategory(_ taskCategory: TaskCategory) {
        if let oldSelectedCategory = selectedCategory {
            categoryList.append(oldSelectedCategory)
        }
        
        selectedCategory = taskCategory
        
        if let index = categoryList.firstIndex(where: { $0.id == taskCategory.id }) {
            categoryList.remove(at: index)
        }
    }
    
    func handleEventSave(journeyId: String, completion: (Business) -> ()) {
        var updatedBusiness = currentBusiness
        
        let event = Event(
            id: eventId ?? UUID().uuidString,
            journeyId: journeyId,
            name: eventName,
            description: eventDescription,
            contentLink: eventLink,
            startDate: startDate,
            endDate: endDate,
            responsibleUserIds: [],
            categoryId: selectedCategory?.id ?? ""
        )
        
        if let eventIndex = updatedBusiness?.events.firstIndex(where: {$0.id == eventId}) {
            updatedBusiness?.events[eventIndex] = event
        } else {
            updatedBusiness?.events.append(event)
        }
        
        completion(updatedBusiness!)
    }
}
