import Foundation

final class SingleJourneyViewModel: ObservableObject {
    
    @Published var journey: Journey
    
    init(journey: Journey) {
        self.journey = journey
    }
    
    func addTask(_ task: Task) {
        self.journey.tasks.append(task)
    }
    
    func removeTask(_ task: Task) {
        if let index = journey.tasks.firstIndex(where: {$0.id == task.id}) {
            self.journey.tasks.remove(at: index)
        }
    }
}
