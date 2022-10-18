import Foundation

final class CreateOrEditTaskViewModel: ObservableObject {
    var taskId: String?
    
    @Published var taskName = ""
    
    @Published var startDate = Date()
    
    @Published var endDate = Date()
    
    @Published var taskDescription = ""
    
    @Published var sampleUsers: [UserModel] = [
        UserModel(id: "121", name: "André Arns", email: "", jobDescription: "Desenvolvedor iOS", personalDescription: "", imageURL: "", businessId: "x"),
        UserModel(id: "122", name: "Ana Costa", email: "", jobDescription: "Designer", personalDescription: "", imageURL: "", businessId: "x"),
        UserModel(id: "123", name: "Raquel Zocoler", email: "", jobDescription: "Designer", personalDescription: "", imageURL: "", businessId: "x"),
        UserModel(id: "124", name: "Pablo Harbar", email: "", jobDescription: "Desenvolvedor iOS", personalDescription: "", imageURL: "", businessId: "x"),
        UserModel(id: "125", name: "Neidivaldo", email: "", jobDescription: "Designer", personalDescription: "", imageURL: "", businessId: "x")
    ]
    
    @Published var sampleCategories: [TaskCategory] = [
        TaskCategory(id: "123", name: "Cultura organizacional", colorName: "vermelho", systemImageName: "lock.fill"),
        TaskCategory(id: "124", name: "Networking", colorName: "roxo", systemImageName: "star.fill"),
        TaskCategory(id: "125", name: "Segurança", colorName: "azulClaro", systemImageName: "checkerboard.shield")
    ]
    
    @Published var selectedCategory: TaskCategory?
    
    @Published var selectedUsers: [UserModel] = []
    
    @Published var showUserList = false
    
    @Published var showCategoryList = false
    
    func isButtonDisabled() -> Bool {
        taskName.isEmpty
    }
    
    func chooseUser(_ user: UserModel) {
        selectedUsers.append(user)
        if let index = sampleUsers.firstIndex(of: user) {
            sampleUsers.remove(at: index)
        }
    }
    
    func removeUser(_ user: UserModel) {
        if let index = selectedUsers.firstIndex(of: user) {
            selectedUsers.remove(at: index)
            sampleUsers.append(user)
        }
    }
    
    func chooseCategory(_ taskCategory: TaskCategory) {
        if let oldSelectedCategory = selectedCategory {
            sampleCategories.append(oldSelectedCategory)
        }
        
        self.selectedCategory = taskCategory
        
        if let index = sampleCategories.firstIndex(where: { $0.id == taskCategory.id}) {
            sampleCategories.remove(at: index)
        }
    }
}
