import Foundation
import SwiftUI

final class BusinessJourneyListViewModel: ObservableObject {
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
    
    func addNewJourney(_ journey: Journey, business: Business, completion: (Business) -> ()) {
        var updatedBusiness = business
        updatedBusiness.journeys.append(journey)
        completion(updatedBusiness)
        selectedJourney = journey
    }
    
    enum NavigationState {
        case journeyList
        case singleJourney
    }
}
