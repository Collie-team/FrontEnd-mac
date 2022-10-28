import Foundation

final class BusinessJourneyListViewModel: ObservableObject {
    @Published var sampleJourneys: [Journey] = [
        Journey(
            name: "Jornada iOS",
            description: "Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo",
            imageURL: URL(fileURLWithPath: ""),
            startDate: Date()
//            employees: [],
//            tasks: [
//                Task(id: "123", name: "Falar com X pessoa", description: "", startDate: Date(), endDate: Date(), taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star")),
//                Task(id: "124", name: "A", description: "", startDate: Date(), endDate: Date(), taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star")),
//                Task(id: "125", name: "B", description: "", startDate: Date(), endDate: Date(), taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star")),
//                Task(id: "126", name: "C", description: "", startDate: Date(), endDate: Date(), taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star")),
//                Task(id: "127", name: "D", description: "", startDate: Date(), endDate: Date(), taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star")),
//                Task(id: "128", name: "E", description: "", startDate: Date(), endDate: Date(), taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star")),
//                Task(id: "129", name: "F", description: "", startDate: Date(), endDate: Date(), taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star")),
//                Task(id: "130", name: "G", description: "", startDate: Date(), endDate: Date(), taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star")),
//                Task(id: "131", name: "H", description: "", startDate: Date(), endDate: Date(), taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star")),
//                Task(id: "132", name: "I", description: "", startDate: Date(), endDate: Date(), taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star")),
//                Task(id: "133", name: "J", description: "", startDate: Date(), endDate: Date(), taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star"))
//            ],
//            events: [],
//            managers: []
        )
    ]
    
    @Published var selectedJourney: Journey?
    
    func addNewJourney(_ journey: Journey) {
        sampleJourneys.append(journey)
        selectedJourney = journey
    }
    
    func saveJourney(_ journey: Journey) {
        if let index = sampleJourneys.firstIndex(where: { $0.id == journey.id }) {
            sampleJourneys[index] = journey
            objectWillChange.send()
        }
    }
}
