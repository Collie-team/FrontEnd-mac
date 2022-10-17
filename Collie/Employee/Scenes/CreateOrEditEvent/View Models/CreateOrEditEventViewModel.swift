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
    
    @Published var sampleCategories: [TaskCategory] = [
        TaskCategory(id: "123", name: "Cultura organizacional", colorName: "vermelho", systemImageName: "lock.fill"),
        TaskCategory(id: "124", name: "Networking", colorName: "roxo", systemImageName: "star.fill"),
        TaskCategory(id: "125", name: "Segurança", colorName: "azulClaro", systemImageName: "checkerboard.shield")
    ]
    
    @Published var sampleUsers: [UserModel] = [
        UserModel(id: "121", name: "André Arns", email: "", jobDescription: "Desenvolvedor iOS", personalDescription: "", imageURL: "", businessId: "x"),
        UserModel(id: "122", name: "Ana Costa", email: "", jobDescription: "Designer", personalDescription: "", imageURL: "", businessId: "x"),
        UserModel(id: "123", name: "Raquel Zocoler", email: "", jobDescription: "Designer", personalDescription: "", imageURL: "", businessId: "x"),
        UserModel(id: "124", name: "Pablo Harbar", email: "", jobDescription: "Desenvolvedor iOS", personalDescription: "", imageURL: "", businessId: "x"),
        UserModel(id: "125", name: "Neidivaldo", email: "", jobDescription: "Designer", personalDescription: "", imageURL: "", businessId: "x")
    ]
    
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
