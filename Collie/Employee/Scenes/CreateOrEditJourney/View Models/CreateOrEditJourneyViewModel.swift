import Foundation

final class CreateNewJourneyViewModel: ObservableObject {
    var journeyId: String?
    
    @Published var journeyName: String = ""
    
    @Published var journeyDescription: String = ""
    
    @Published var showManagerList = false
    
    @Published var showUsersList = false
    
    @Published var chosenManagers: [UserModel] = []
    
    @Published var chosenEmployees: [UserModel] = []
    
    @Published var startDate: Date = Date()
    
    @Published var tasks: [Task] = []
    
    @Published var events: [Event] = []
    
    @Published var sampleManagers: [UserModel] = [
        UserModel(name: "André Arns", email: "", jobDescription: "Desenvolvedor iOS", personalDescription: "", imageURL: "", businessId: []),
        UserModel(name: "Ana Costa", email: "", jobDescription: "Designer", personalDescription: "", imageURL: "", businessId: []),
        UserModel(name: "Raquel Zocoler", email: "", jobDescription: "Designer", personalDescription: "", imageURL: "", businessId: []),
        UserModel(name: "Pablo Harbar", email: "", jobDescription: "Desenvolvedor iOS", personalDescription: "", imageURL: "", businessId: []),
        UserModel(name: "Neidivaldo", email: "", jobDescription: "Designer", personalDescription: "", imageURL: "", businessId: [])
    ]
    
    @Published var sampleUsers: [UserModel] = [
        UserModel(name: "André Arns", email: "", jobDescription: "Desenvolvedor iOS", personalDescription: "", imageURL: "", businessId: []),
        UserModel(name: "Ana Costa", email: "", jobDescription: "Designer", personalDescription: "", imageURL: "", businessId: []),
        UserModel(name: "Raquel Zocoler", email: "", jobDescription: "Designer", personalDescription: "", imageURL: "", businessId: []),
        UserModel(name: "Pablo Harbar", email: "", jobDescription: "Desenvolvedor iOS", personalDescription: "", imageURL: "", businessId: []),
        UserModel(name: "Neidivaldo", email: "", jobDescription: "Designer", personalDescription: "", imageURL: "", businessId: [])
    ]
    
    func isButtonDisabled() -> Bool {
        journeyName == "" || journeyDescription == "" || chosenManagers.isEmpty || startDate == nil
    }
    
    func selectManager(_ userModel: UserModel) {
        if !chosenManagers.contains(userModel) {
            self.chosenManagers.append(userModel)
            
            if let index = sampleManagers.firstIndex(of: userModel) {
                sampleManagers.remove(at: index)
            }
        }
    }
    
    func removeManager(_ userModel: UserModel) {
        if let index = chosenManagers.firstIndex(of: userModel) {
            chosenManagers.remove(at: index)
            sampleManagers.append(userModel)
        }
    }
    
    func selectUserModel(_ userModel: UserModel) {
        if !chosenEmployees.contains(userModel) {
            chosenEmployees.append(userModel)
            
            if let index = sampleUsers.firstIndex(of: userModel) {
                sampleUsers.remove(at: index)
            }
        }
    }
    
    func removeUserModel(_ userModel: UserModel) {
        if let index = chosenEmployees.firstIndex(of: userModel) {
            chosenEmployees.remove(at: index)
            sampleUsers.append(userModel)
        }
    }
}
