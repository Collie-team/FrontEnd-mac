import Foundation

final class EmployeeSingleJourneyViewModel: ObservableObject {
    
    struct TaskModel: Identifiable {
        var id: String {
            task.id
        }
        var task: Task
        var userTask: UserTask?
    }
    
    var journey: Journey
    
    private var userTasks: [UserTask] = [] {
        didSet {
            syncTasks()
        }
    }
    
    private var allTasks: [Task] = [] {
        didSet {
            syncTasks()
        }
    }
    
    @Published var allTaskModels: [TaskModel] = []
    
    @Published var lateTaskModels: [TaskModel] = []
    
    @Published var dailyTaskModels: [TaskModel] = []
    
    @Published var nextTaskModels: [TaskModel] = []
    
    @Published var doneTaskModels: [TaskModel] = []
    
    @Published var chosenTaskModel: TaskModel?
    
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
    
    func handleAppear() {
        bind()
    }
    
    func bind() {
        self.allTasks = journey.tasks
        let userTasks: [UserTask] = [
            UserTask(taskId: "129", journeyId: "teste", doneDate: Date().timeIntervalSince1970),
            UserTask(taskId: "130", journeyId: "teste", doneDate: Date().timeIntervalSince1970),
            UserTask(taskId: "131", journeyId: "teste", doneDate: Date().timeIntervalSince1970),
            UserTask(taskId: "132", journeyId: "teste", doneDate: Date().timeIntervalSince1970),
            UserTask(taskId: "133", journeyId: "teste", doneDate: Date().timeIntervalSince1970),
        ]
        self.userTasks = userTasks
        separateTaskModels()
    }
    
    private func syncTasks() {
        self.allTaskModels = allTasks.map({ task in
            let taskModel = TaskModel(task: task, userTask: self.userTasks.first(where: { $0.id == task.id }) ?? UserTask(taskId: task.id, journeyId: journey.id))
            return taskModel
        })
        
        separateTaskModels()
    }
    
    // MARK: - Task functions
    func isTaskModelLate(_ taskModel: TaskModel) -> Bool {
        (taskModel.task.endDate.timeIntervalSince1970 < Date().timeIntervalSince1970) && taskModel.userTask?.doneDate == nil
    }
    
    func saveTaskModel(_ taskModel: TaskModel) {
        // TO DO
    }
    
    func selectTaskModel(_ taskModel: TaskModel) {
        self.chosenTaskModel = taskModel
    }
    
    func unselectTask() {
        chosenTaskModel = nil
    }
    
    func checkTaskModel(_ taskModel: TaskModel) {
        if let index = self.allTaskModels.firstIndex(where: { $0.id == taskModel.id }) {
            if taskModel.userTask?.doneDate != nil {
                let userTask = UserTask(taskId: taskModel.task.id, journeyId: journey.id, doneDate: nil)
                allTaskModels[index] = TaskModel(task: allTaskModels[index].task, userTask: userTask)
            } else {
                let userTask = UserTask(taskId: taskModel.task.id, journeyId: journey.id, doneDate: Date().timeIntervalSince1970)
                allTaskModels[index] = TaskModel(task: allTaskModels[index].task, userTask: userTask)
            }
            
            separateTaskModels()
        }
    }
    
    func isTaskModelChecked(_ taskModel: TaskModel) -> Bool {
        if let userTask = taskModel.userTask {
            return userTask.doneDate != nil
        } else {
            return false
        }
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
    
    func separateTaskModels() {
        self.doneTaskModels = allTaskModels.filter({ taskModel in
            taskModel.userTask?.doneDate != nil
        })
        
        self.dailyTaskModels = allTaskModels.filter({ taskModel in
            taskModel.task.endDate < CalendarHelper().endOfTheDay(of: Date()) && taskModel.userTask?.doneDate == nil
        })
        
        self.nextTaskModels = allTaskModels.filter({ taskModel in
            taskModel.task.endDate > CalendarHelper().endOfTheDay(of: Date()) && taskModel.userTask?.doneDate == nil
        })
    }
}
