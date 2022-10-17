import Foundation

final class SingleJourneyViewModel: ObservableObject {
    
    @Published var journey: Journey {
        didSet {
            filterSelectedEvents()
        }
    }
    
    @Published var chosenTask: Task?
    
    @Published var chosenEvent: Event?
    
    @Published var categories: [TaskCategory] = [
        TaskCategory(name: "Integração", colorName: "vermelho", systemImageName: "star"),
        TaskCategory(name: "Integração", colorName: "roxo", systemImageName: "lock"),
        TaskCategory(name: "Integração", colorName: "amarelo", systemImageName: "star"),
        TaskCategory(name: "Integração", colorName: "verde", systemImageName: "lock")
    ]
    
    @Published var selectedEvents: [Event] = []
    
    @Published var selectedDate: Date = Date() {
        didSet {
            filterSelectedEvents()
        }
    }
    
    init(journey: Journey) {
        self.journey = journey
        filterSelectedEvents()
    }
    
    // MARK: - Task functions
    func saveTask(_ task: Task) {
        if let index = self.journey.tasks.firstIndex(where: { $0.id == task.id }) {
            self.journey.tasks[index] = task
        } else {
            self.journey.tasks.append(task)
        }
        objectWillChange.send()
    }
    
    func removeTask(_ task: Task) {
        if let index = journey.tasks.firstIndex(where: {$0.id == task.id}) {
            self.journey.tasks.remove(at: index)
        }
        objectWillChange.send()
    }
    
    func duplicateTask(_ task: Task) {
        var duplicatedTask = task
        duplicatedTask.id = UUID().uuidString
        self.journey.tasks.append(duplicatedTask)
    }
    
    func selectTask(_ task: Task) {
        self.chosenTask = task
    }
    
    func unselectTask() {
        chosenTask = nil
    }
    
    // MARK: - Event functions
    func saveEvent(_ event: Event) {
        if let index = self.journey.events.firstIndex(where: { $0.id == event.id }) {
            self.journey.events[index] = event
        } else {
            self.journey.events.append(event)
            sortJourneyEvents()
        }
        objectWillChange.send()
    }
    
    func removeEvent(_ event: Event) {
        if let index = journey.events.firstIndex(where: {$0.id == event.id}) {
            self.journey.events.remove(at: index)
        }
        objectWillChange.send()
    }
    
    func duplicateEvent(_ event: Event) {
        var duplicatedEvent = event
        duplicatedEvent.id = UUID().uuidString
        self.journey.events.append(duplicatedEvent)
    }
    
    func selectEvent(_ event: Event) {
        self.chosenEvent = event
    }
    
    func unselectEvent() {
        chosenEvent = nil
    }
    
    func sortJourneyEvents() {
        self.journey.events = self.journey.events.sorted(by: { eventA, eventB in
            eventA.startDate < eventB.startDate
        })
    }
    
    func filterSelectedEvents() {
        self.selectedEvents = journey.events.filter({ event in
            CalendarHelper().areDatesInSameDay(event.startDate, selectedDate)
        })
    }
}
