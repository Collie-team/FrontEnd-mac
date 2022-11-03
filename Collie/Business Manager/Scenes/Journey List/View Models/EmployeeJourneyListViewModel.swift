import Foundation

final class EmployeeJourneyListViewModel: ObservableObject {
    @Published var sampleJourneys: [Journey] = [
        Journey(
            id: "teste",
            name: "Jornada iOS",
//            duration: 10,
            description: "Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo",
            imageURL: URL(fileURLWithPath: ""),
            employees: [],
            tasks: [
                Task(id: "123", name: "Falar com X pessoa", description: "", startDate: Date(), endDate: Date(), taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star")),
                Task(id: "124", name: "A", description: "", startDate: Date(timeIntervalSince1970: 1668972239), endDate: Date(timeIntervalSince1970: 1668972239), taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star")),
                Task(id: "125", name: "B", description: "", startDate: Date(timeIntervalSince1970: 1668972239), endDate: Date(timeIntervalSince1970: 1668972239), taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star")),
                Task(id: "126", name: "C", description: "", startDate: Date(timeIntervalSince1970: 1668972239), endDate: Date(timeIntervalSince1970: 1668972239), taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star")),
                Task(id: "127", name: "D", description: "", startDate: Date(timeIntervalSince1970: 1664389712), endDate: Date(timeIntervalSince1970: 1664389712), taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star")),
                Task(id: "128", name: "E", description: "", startDate: Date(timeIntervalSince1970: 1664389712), endDate: Date(timeIntervalSince1970: 1664389712), taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star")),
                Task(id: "129", name: "F", description: "", startDate: Date(timeIntervalSince1970: 1664389712), endDate: Date(), taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star")),
                Task(id: "130", name: "G", description: "", startDate: Date(timeIntervalSince1970: 1644866400), endDate: Date(timeIntervalSince1970: 1644866400), taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star")),
                Task(id: "131", name: "H", description: "", startDate: Date(), endDate: Date(), taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star")),
                Task(id: "132", name: "I", description: "", startDate: Date(), endDate: Date(), taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star")),
                Task(id: "133", name: "J", description: "", startDate: Date(), endDate: Date(), taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star"))
            ],
            events: [
                Event(name: "Workshop de programação", description: "Descrição", link: "", startDate: Date(), endDate: Date()),
                Event(name: "Workshop de design", description: "Descrição", link: "", startDate: Date(), endDate: Date())
            ],
            managers: []
        )
    ]
    
    @Published var selectedJourney: Journey?
    
    func saveJourney(_ journey: Journey) {
        if let index = sampleJourneys.firstIndex(where: { $0.id == journey.id }) {
            sampleJourneys[index] = journey
            objectWillChange.send()
        }
    }
}
