import Foundation

final class SingleJourneyViewModel: ObservableObject {
    
    @Published var journey: Journey
    
    @Published var chosenTask: Task?
    
    @Published var chosenEvent: Event?
    
    @Published var categories: [TaskCategory] = [
        TaskCategory(name: "Integração", colorName: "vermelho", systemImageName: "star"),
        TaskCategory(name: "Integração", colorName: "roxo", systemImageName: "lock"),
        TaskCategory(name: "Integração", colorName: "amarelo", systemImageName: "star"),
        TaskCategory(name: "Integração", colorName: "verde", systemImageName: "lock")
    ]
    
    init(journey: Journey) {
        self.journey = journey
    }
    
    func saveTask(_ task: Task) {
        if let index = self.journey.tasks.firstIndex(where: { $0.id == task.id }) {
            self.journey.tasks[index] = task
        } else {
            self.journey.tasks.append(task)
        }
    }
    
    func saveEvent(_ event: Event) {
        if let index = self.journey.events.firstIndex(where: { $0.id == event.id }) {
            self.journey.events[index] = event
        } else {
            self.journey.events.append(event)
            sortJourneyEvents()
        }
    }
    
    func sortJourneyEvents() {
        self.journey.events = self.journey.events.sorted(by: { eventA, eventB in
            eventA.startDate < eventB.startDate
        })
    }
    
    func removeTask(_ task: Task) {
        if let index = journey.tasks.firstIndex(where: {$0.id == task.id}) {
            self.journey.tasks.remove(at: index)
        }
    }
    
    func selectTask(_ task: Task) {
        self.chosenTask = task
    }
    
    func selectEvent(_ event: Event) {
        self.chosenEvent = event
    }
    
    func unselectTask() {
        chosenTask = nil
    }
    
    func unselectEvent() {
        chosenEvent = nil
    }
}
