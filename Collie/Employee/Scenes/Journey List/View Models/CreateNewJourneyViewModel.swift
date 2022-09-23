import Foundation

final class CreateNewJourneyViewModel: ObservableObject {
    @Published var journeyName: String = ""
    @Published var journeyDescription: String = ""
    @Published var chosenManagers: [User] = []
    @Published var chosenUsers: [User] = []
    @Published var startDate: Date = Date()
    
    @Published var sampleManagers: [User] = [
        User(name: "André Arns", email: "", jobDescription: "Desenvolvedor iOS", personalDescription: "", imageURL: "", businessId: "x"),
        User(name: "Ana Costa", email: "", jobDescription: "Designer", personalDescription: "", imageURL: "", businessId: "x"),
        User(name: "Raquel Zocoler", email: "", jobDescription: "Designer", personalDescription: "", imageURL: "", businessId: "x"),
        User(name: "Pablo Harbar", email: "", jobDescription: "Desenvolvedor iOS", personalDescription: "", imageURL: "", businessId: "x"),
        User(name: "Neidivaldo", email: "", jobDescription: "Designer", personalDescription: "", imageURL: "", businessId: "x")
    ]
    
    @Published var sampleUsers: [User] = [
        User(name: "André Arns", email: "", jobDescription: "Desenvolvedor iOS", personalDescription: "", imageURL: "", businessId: "x"),
        User(name: "Ana Costa", email: "", jobDescription: "Designer", personalDescription: "", imageURL: "", businessId: "x"),
        User(name: "Raquel Zocoler", email: "", jobDescription: "Designer", personalDescription: "", imageURL: "", businessId: "x"),
        User(name: "Pablo Harbar", email: "", jobDescription: "Desenvolvedor iOS", personalDescription: "", imageURL: "", businessId: "x"),
        User(name: "Neidivaldo", email: "", jobDescription: "Designer", personalDescription: "", imageURL: "", businessId: "x")
    ]
    
    func isButtonDisabled() -> Bool {
        journeyName == "" || journeyDescription == "" || chosenManagers.isEmpty || startDate == nil
    }
    
    func selectManager(_ user: User) {
        if !chosenManagers.contains(user) {
            self.chosenManagers.append(user)
            
            if let index = sampleManagers.firstIndex(of: user) {
                sampleManagers.remove(at: index)
            }
        }
    }
    
    func removeManager(_ user: User) {
        if let index = chosenManagers.firstIndex(of: user) {
            chosenManagers.remove(at: index)
            sampleManagers.append(user)
        }
    }
    
    func selectUser(_ user: User) {
        if !chosenUsers.contains(user) {
            chosenUsers.append(user)
            
            if let index = sampleUsers.firstIndex(of: user) {
                sampleUsers.remove(at: index)
            }
        }
    }
    
    func removeUser(_ user: User) {
        if let index = chosenUsers.firstIndex(of: user) {
            chosenUsers.remove(at: index)
            sampleUsers.append(user)
        }
    }
}
