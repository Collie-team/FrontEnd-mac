import Foundation

final class CreateNewJourneyViewModel: ObservableObject {
    @Published var journeyId: String = ""
    
    @Published var journeyName: String = ""
    
    @Published var journeyDescription: String = ""
    
    @Published var showUsersList = false
    
    @Published var chosenEmployees: [UserModel] = []
    
    @Published var startDate: Date = Date()
    
    @Published var tasks: [Task] = []
    
    @Published var events: [Event] = []
    
    @Published var sampleUsers: [UserModel] = [
        UserModel(name: "André Arns", email: "", jobDescription: "Desenvolvedor iOS", personalDescription: "", imageURL: ""),
        UserModel(name: "Ana Costa", email: "", jobDescription: "Designer", personalDescription: "", imageURL: ""),
        UserModel(name: "Raquel Zocoler", email: "", jobDescription: "Designer", personalDescription: "", imageURL: ""),
        UserModel(name: "Pablo Harbar", email: "", jobDescription: "Desenvolvedor iOS", personalDescription: "", imageURL: ""),
        UserModel(name: "Neidivaldo", email: "", jobDescription: "Designer", personalDescription: "", imageURL: "")
    ]
    
    func isButtonDisabled() -> Bool {
        journeyName == "" || journeyDescription == "" || startDate == nil
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
