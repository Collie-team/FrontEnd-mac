import Foundation

final class EmployeeSingleJourneyViewModel: ObservableObject {
    @Published var journey: Journey {
        didSet {
            filterSelectedEvents()
        }
    }
    
    @Published var dailyTasks: [Task] = []
    
    @Published var nextTasks: [Task] = []
    
    @Published var doneTasks: [Task] = []
    
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
        separateJourneyTasks()
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
    
    func separateJourneyTasks() {
        self.dailyTasks = journey.tasks.filter({ task in
            CalendarHelper().areDatesInSameDay(task.startDate, Date())
        })
        
        self.nextTasks = journey.tasks.filter({ task in
            !dailyTasks.contains(where: { $0.id == task.id })
        })
    }
}
