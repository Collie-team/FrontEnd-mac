import Foundation

final class TeamListViewModel: ObservableObject {
    @Published var sampleUsers: [User] = [
        User(name: "André Arns", email: "", jobDescription: "Desenvolvedor iOS", personalDescription: "", imageURL: "", businessId: "x"),
        User(name: "Ana Costa", email: "", jobDescription: "Designer", personalDescription: "", imageURL: "", businessId: "x"),
        User(name: "Raquel Zocoler", email: "", jobDescription: "Designer", personalDescription: "", imageURL: "", businessId: "x"),
        User(name: "Pablo Harbar", email: "", jobDescription: "Desenvolvedor iOS", personalDescription: "", imageURL: "", businessId: "x"),
        User(name: "Neidivaldo", email: "", jobDescription: "Designer", personalDescription: "", imageURL: "", businessId: "x")
    ]
}
