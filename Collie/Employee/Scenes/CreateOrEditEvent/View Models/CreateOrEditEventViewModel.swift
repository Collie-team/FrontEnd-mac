import Foundation

final class CreateOrEditEventViewModel: ObservableObject {
    var eventId: String?
    
    @Published var eventName = ""
    
    @Published var startDate = Date()
    
    @Published var endDate = Date()
    
    @Published var eventLink = ""
    
    @Published var selectedUsers: [UserModel] = []
    
    @Published var eventDescription = ""
    
    @Published var selectedCategory: TaskCategory?
    
    @Published var showUserList = false
    
    @Published var showCategoryList = false
    
    @Published var sampleCategories: [TaskCategory] = []
    
    @Published var sampleUsers: [UserModel] = []
    
    func isButtonDisabled() -> Bool {
        eventName.isEmpty
    }
    
    func selectUser(_ userModel: UserModel) {
        selectedUsers.append(userModel)
        if let index = sampleUsers.firstIndex(where: { $0.id == userModel.id }) {
            sampleUsers.remove(at: index)
        }
    }
    
    func removeUser(_ userModel: UserModel) {
        if let index = selectedUsers.firstIndex(where: { $0.id == userModel.id }) {
            selectedUsers.remove(at: index)
            sampleUsers.append(userModel)
        }
    }
    
    func selectCategory(_ taskCategory: TaskCategory) {
        if let oldSelectedCategory = selectedCategory {
            sampleCategories.append(oldSelectedCategory)
        }
        
        selectedCategory = taskCategory
        
        if let index = sampleCategories.firstIndex(where: { $0.id == taskCategory.id }) {
            sampleCategories.remove(at: index)
        }
    }
}
