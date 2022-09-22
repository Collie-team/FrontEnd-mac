import Foundation

final class CreateNewJourneyViewModel: ObservableObject {
    @Published var journeyName: String = ""
    @Published var journeyDescription: String = ""
    @Published var chosenManager: User? = nil
    @Published var chosenUsers: [User] = []
    
    @Published var sampleManagers: [User] = [
        User(name: "André Arns", email: "", jobDescription: "Desenvolvedor iOS", personalDescription: "", imageURL: "", businessId: "x"),
        User(name: "Ana Costa", email: "", jobDescription: "Designer", personalDescription: "", imageURL: "", businessId: "x"),
        User(name: "Raquel Zocoler", email: "", jobDescription: "Designer", personalDescription: "", imageURL: "", businessId: "x"),
        User(name: "Pablo Harbar", email: "", jobDescription: "Desenvolvedor iOS", personalDescription: "", imageURL: "", businessId: "x"),
        User(name: "Neidivaldo", email: "", jobDescription: "Designer", personalDescription: "", imageURL: "", businessId: "x")
    ]
    
    func isButtonDisabled() -> Bool {
        journeyName == "" || journeyDescription == "" || chosenManager == nil
    }
    
    func selectManager(_ user: User) {
        self.chosenManager = user
    }
    
    func addUser(_ user: User) {
        chosenUsers.append(user)
    }
    
    func removeUser(_ user: User) {
        if let index = chosenUsers.firstIndex(of: user) {
            chosenUsers.remove(at: index)
        }
    }
}
