import Foundation

final class CreateNewJourneyViewModel: ObservableObject {
    @Published var journeyName: String = ""
    @Published var journeyDescription: String = ""
    @Published var chosenManagers: [UserModel] = []
    @Published var chosenUsers: [UserModel] = []
    @Published var startDate: Date = Date()
    
    @Published var sampleManagers: [UserModel] = [
        UserModel(name: "André Arns", email: "", jobDescription: "Desenvolvedor iOS", personalDescription: "", imageURL: "", businessId: "x"),
        UserModel(name: "Ana Costa", email: "", jobDescription: "Designer", personalDescription: "", imageURL: "", businessId: "x"),
        UserModel(name: "Raquel Zocoler", email: "", jobDescription: "Designer", personalDescription: "", imageURL: "", businessId: "x"),
        UserModel(name: "Pablo Harbar", email: "", jobDescription: "Desenvolvedor iOS", personalDescription: "", imageURL: "", businessId: "x"),
        UserModel(name: "Neidivaldo", email: "", jobDescription: "Designer", personalDescription: "", imageURL: "", businessId: "x")
    ]
    
    @Published var sampleUsers: [UserModel] = [
        UserModel(name: "André Arns", email: "", jobDescription: "Desenvolvedor iOS", personalDescription: "", imageURL: "", businessId: "x"),
        UserModel(name: "Ana Costa", email: "", jobDescription: "Designer", personalDescription: "", imageURL: "", businessId: "x"),
        UserModel(name: "Raquel Zocoler", email: "", jobDescription: "Designer", personalDescription: "", imageURL: "", businessId: "x"),
        UserModel(name: "Pablo Harbar", email: "", jobDescription: "Desenvolvedor iOS", personalDescription: "", imageURL: "", businessId: "x"),
        UserModel(name: "Neidivaldo", email: "", jobDescription: "Designer", personalDescription: "", imageURL: "", businessId: "x")
    ]
    
    func isButtonDisabled() -> Bool {
        journeyName == "" || journeyDescription == "" || chosenManagers.isEmpty || startDate == nil
    }
    
    func selectManager(_ user: UserModel) {
        if !chosenManagers.contains(user) {
            self.chosenManagers.append(user)
            
            if let index = sampleManagers.firstIndex(of: user) {
                sampleManagers.remove(at: index)
            }
        }
    }
    
    func removeManager(_ user: UserModel) {
        if let index = chosenManagers.firstIndex(of: user) {
            chosenManagers.remove(at: index)
            sampleManagers.append(user)
        }
    }
    
    func selectUser(_ user: UserModel) {
        if !chosenUsers.contains(user) {
            chosenUsers.append(user)
            
            if let index = sampleUsers.firstIndex(of: user) {
                sampleUsers.remove(at: index)
            }
        }
    }
    
    func removeUser(_ user: UserModel) {
        if let index = chosenUsers.firstIndex(of: user) {
            chosenUsers.remove(at: index)
            sampleUsers.append(user)
        }
    }
}
