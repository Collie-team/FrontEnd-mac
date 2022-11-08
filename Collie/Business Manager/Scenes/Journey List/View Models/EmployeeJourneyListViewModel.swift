import Foundation

final class EmployeeJourneyListViewModel: ObservableObject {
    @Published var sampleJourneys: [Journey] = [
        Journey(
            name: "Jornada iOS",
            description: "Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo",
            imageURL: "",
            startDate: Date(),
            userIds: []
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
