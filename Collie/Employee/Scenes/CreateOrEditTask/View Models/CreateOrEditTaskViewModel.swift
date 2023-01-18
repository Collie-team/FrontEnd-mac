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
    
    var currentBusiness: Business
    
    init(currentBusiness: Business) {
        self.currentBusiness = currentBusiness
        self.categoryList = currentBusiness.categories
    }
    
    func isButtonDisabled() -> Bool {
        taskName.isEmpty
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
            categoryId: selectedCategory?.id ?? "",
            startDate: startDate,
            endDate: endDate
        )
        
        if let taskIndex = updatedBusiness.tasks.firstIndex(where: {$0.id == taskId}) {
            updatedBusiness.tasks[taskIndex] = task
        } else {
            updatedBusiness.tasks.append(task)
        }
        
        completion(updatedBusiness)
    }
}
