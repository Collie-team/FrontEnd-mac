import Foundation

final class JourneyListViewModel: ObservableObject {
    @Published var sampleJourneys: [Journey] = [
        Journey(
            name: "Jornada iOS",
            durationInDays: 7,
            description: "Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo",
            imageURL: URL(fileURLWithPath: ""),
            usersIds: [],
            tasks: [
                Task(name: "Falar com X pessoa", description: "", taskCategory: TaskCategory(name: "Integração", description: "", colorName: "")),
                Task(name: "A", description: "", taskCategory: TaskCategory(name: "Integração", description: "", colorName: "")),
                Task(name: "B", description: "", taskCategory: TaskCategory(name: "Integração", description: "", colorName: "")),
                Task(name: "C", description: "", taskCategory: TaskCategory(name: "Integração", description: "", colorName: "")),
                Task(name: "D", description: "", taskCategory: TaskCategory(name: "Integração", description: "", colorName: "")),
                Task(name: "E", description: "", taskCategory: TaskCategory(name: "Integração", description: "", colorName: "")),
                Task(name: "F", description: "", taskCategory: TaskCategory(name: "Integração", description: "", colorName: "")),
                Task(name: "G", description: "", taskCategory: TaskCategory(name: "Integração", description: "", colorName: "")),
                Task(name: "H", description: "", taskCategory: TaskCategory(name: "Integração", description: "", colorName: "")),
                Task(name: "I", description: "", taskCategory: TaskCategory(name: "Integração", description: "", colorName: "")),
                Task(name: "J", description: "", taskCategory: TaskCategory(name: "Integração", description: "", colorName: ""))
            ],
            managers: []
        )
    ]
    
    @Published var selectedJourney: Journey?
    
    func addNewJourney(_ journey: Journey) {
        sampleJourneys.append(journey)
        selectedJourney = journey
    }
}
