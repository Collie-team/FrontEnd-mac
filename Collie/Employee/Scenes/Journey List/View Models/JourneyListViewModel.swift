import Foundation

final class JourneyListViewModel: ObservableObject {
    @Published var sampleJourneys: [Journey] = [
        Journey(title: "Jornada iOS", subtitle: "", imageName: ""),
        Journey(title: "Jornada de Design", subtitle: "", imageName: ""),
        Journey(title: "Jornada de RH", subtitle: "", imageName: ""),
        Journey(title: "Jornada do Capiroto", subtitle: "", imageName: ""),
    ]
}
