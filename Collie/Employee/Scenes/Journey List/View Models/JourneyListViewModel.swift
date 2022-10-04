import Foundation

final class JourneyListViewModel: ObservableObject {
    @Published var sampleJourneys: [Journey] = [
        Journey(
            name: "Jornada iOS",
            startDate: Date(),
            description: "Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo",
            imageURL: URL(fileURLWithPath: ""),
            employees: [],
            tasks: [
                Task(name: "Falar com X pessoa", description: "", startDate: Date(), endDate: Date(), taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star")),
                Task(name: "A", description: "", startDate: Date(), endDate: Date(), taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star")),
                Task(name: "B", description: "", startDate: Date(), endDate: Date(), taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star")),
                Task(name: "C", description: "", startDate: Date(), endDate: Date(), taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star")),
                Task(name: "D", description: "", startDate: Date(), endDate: Date(), taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star")),
                Task(name: "E", description: "", startDate: Date(), endDate: Date(), taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star")),
                Task(name: "F", description: "", startDate: Date(), endDate: Date(), taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star")),
                Task(name: "G", description: "", startDate: Date(), endDate: Date(), taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star")),
                Task(name: "H", description: "", startDate: Date(), endDate: Date(), taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star")),
                Task(name: "I", description: "", startDate: Date(), endDate: Date(), taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star")),
                Task(name: "J", description: "", startDate: Date(), endDate: Date(), taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star"))
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
