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
    
    enum NavigationState {
        case journeyList
        case singleJourney
    }
}
