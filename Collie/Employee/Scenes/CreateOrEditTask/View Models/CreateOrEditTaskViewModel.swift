import Foundation

final class CreateOrEditTaskViewModel: ObservableObject {
    var taskId: String?
    
    @Published var taskName = ""
    
    @Published var startDate = Date()
    
    @Published var endDate = Date()
    
    @Published var taskDescription = ""
    
    @Published var sampleUsers: [User] = [
        User(id: "121", name: "André Arns", email: "", jobDescription: "Desenvolvedor iOS", personalDescription: "", imageURL: "", businessId: "x"),
        User(id: "122", name: "Ana Costa", email: "", jobDescription: "Designer", personalDescription: "", imageURL: "", businessId: "x"),
        User(id: "123", name: "Raquel Zocoler", email: "", jobDescription: "Designer", personalDescription: "", imageURL: "", businessId: "x"),
        User(id: "124", name: "Pablo Harbar", email: "", jobDescription: "Desenvolvedor iOS", personalDescription: "", imageURL: "", businessId: "x"),
        User(id: "125", name: "Neidivaldo", email: "", jobDescription: "Designer", personalDescription: "", imageURL: "", businessId: "x")
    ]
    
    @Published var sampleCategories: [TaskCategory] = [
        TaskCategory(id: "123", name: "Cultura organizacional", colorName: "vermelho", systemImageName: "lock.fill"),
        TaskCategory(id: "124", name: "Networking", colorName: "roxo", systemImageName: "star.fill"),
        TaskCategory(id: "125", name: "Segurança", colorName: "azulClaro", systemImageName: "checkerboard.shield")
    ]
    
    @Published var selectedCategory: TaskCategory?
    
    @Published var selectedUsers: [User] = []
    
    @Published var showUserList = false
    
    @Published var showCategoryList = false
    
    func isButtonDisabled() -> Bool {
        taskName.isEmpty
    }
    
    func chooseUser(_ user: User) {
        selectedUsers.append(user)
        if let index = sampleUsers.firstIndex(of: user) {
            sampleUsers.remove(at: index)
        }
    }
    
    func removeUser(_ user: User) {
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
