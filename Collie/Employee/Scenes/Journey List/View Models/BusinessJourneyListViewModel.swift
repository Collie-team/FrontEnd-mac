import Foundation
import SwiftUI

final class BusinessJourneyListViewModel: ObservableObject {
    @Published var sampleJourneys: [Journey] = [
        Journey(
            name: "Jornada iOS",
            description: "Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo",
            imageURL: "",
            startDate: Date(),
            userIds: []
        )
    ]
        
    @Published var selectedJourney: Journey? {
        didSet {
            guard let _ = selectedJourney else {
                navigationState = .journeyList
                return
            }
            navigationState = .singleJourney
        }
    }
        
    @Published var navigationState: NavigationState = .journeyList
    
    func addNewJourney(_ journey: Journey) {
        sampleJourneys.append(journey)
        selectedJourney = journey
    }
    
    enum NavigationState {
        case journeyList
        case singleJourney
    }
}
