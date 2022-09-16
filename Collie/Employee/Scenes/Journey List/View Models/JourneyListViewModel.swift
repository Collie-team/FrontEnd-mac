import Foundation

final class JourneyListViewModel: ObservableObject {
    @Published var sampleJourneys: [Journey] = [
        Journey(title: "Jornada iOS", subtitle: "Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo", imageName: ""),
        Journey(title: "Jornada de Design", subtitle: "Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo", imageName: ""),
        Journey(title: "Jornada de RH", subtitle: "Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo", imageName: ""),
        Journey(title: "Jornada do Capiroto", subtitle: "Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo", imageName: ""),
    ]
    
    @Published var selectedJourney: Journey?
    
    func addNewJourney() {
        let newJourney = Journey(title: "Nova jornada", subtitle: "Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo", imageName: "")
        sampleJourneys.append(newJourney)
        selectedJourney = newJourney
    }
}
