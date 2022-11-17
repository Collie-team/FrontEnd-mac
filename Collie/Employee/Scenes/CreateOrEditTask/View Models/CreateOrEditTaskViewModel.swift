import Foundation

final class CreateOrEditTaskViewModel: ObservableObject {
    private let teamListService = TeamSubscriptionService()
    
    var taskId: String?
    
    @Published var taskName = ""
    
    @Published var startDate = Date()
    
    @Published var endDate = Date()
    
    @Published var taskDescription = ""
    
    @Published var categoryList: [TaskCategory]
    
    @Published var selectedCategory: TaskCategory?
    
    @Published var chosenUserModels: [UserModel] = []
    
    @Published var userModelList: [UserModel] = []
    
    @Published var showUserList = false
    
    @Published var showCategoryList = false
    
    var currentBusiness: Business?
    
    init(categoryList: [TaskCategory]) {
        self.categoryList = categoryList
    }
    
    func isButtonDisabled() -> Bool {
        taskName.isEmpty
    }
    
    func fetchUsers(business: Business) {
        currentBusiness = business
        teamListService.fetchTeamInfo(business: business, authenticationToken: "TO DO") { businessUsers, userModels in
            self.userModelList = userModels
            
            // Load chosen user Models
            self.fetchOldUsersOnTask()
        }
    }
    
    func fetchOldUsersOnTask() {
        self.chosenUserModels = userModelList.filter({ user in
            if let journey = currentBusiness!.journeys.first(where: {$0.id == self.taskId}) {
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
    
    func chooseUser(_ userModel: UserModel) {
        chosenUserModels.append(userModel)
        
        if let index = userModelList.firstIndex(of: userModel) {
            userModelList.remove(at: index)
        }
    }
    
    func removeUser(_ userModel: UserModel) {
        if let index = chosenUserModels.firstIndex(of: userModel) {
            chosenUserModels.remove(at: index)
            userModelList.append(userModel)
        }
    }
    
    func chooseCategory(_ taskCategory: TaskCategory) {
        if let oldSelectedCategory = selectedCategory {
            categoryList.append(oldSelectedCategory)
        }
        
        self.selectedCategory = taskCategory
        
        if let index = categoryList.firstIndex(where: { $0.id == taskCategory.id}) {
            categoryList.remove(at: index)
        }
    }
    
    func handleTaskSave(journeyId: String, completion: (Business) -> ()) {
        var updatedBusiness = currentBusiness
        
        let task = Task(
            id: taskId ?? UUID().uuidString,
            journeyId: journeyId,
            name: taskName,
            description: taskDescription,
            categoryId: selectedCategory?.id,
            startDate: startDate,
            endDate: endDate
        )
        
        if let taskIndex = updatedBusiness?.tasks.firstIndex(where: {$0.id == taskId}) {
            updatedBusiness?.tasks[taskIndex] = task
        } else {
            updatedBusiness?.tasks.append(task)
        }
        
        completion(updatedBusiness!)
    }
}
