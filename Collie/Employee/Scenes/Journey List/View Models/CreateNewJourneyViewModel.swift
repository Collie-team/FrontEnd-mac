import Foundation

final class CreateNewJourneyViewModel: ObservableObject {
    @Published var journeyName: String = ""
    @Published var journeyDescription: String = ""
    
    func isButtonDisabled() -> Bool {
        journeyName == "" || journeyDescription == ""
    }
}
