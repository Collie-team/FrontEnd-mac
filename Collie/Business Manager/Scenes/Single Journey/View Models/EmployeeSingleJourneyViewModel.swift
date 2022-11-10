import Foundation

final class EmployeeSingleJourneyViewModel: ObservableObject {
    
    struct TaskModel: Identifiable {
        var id: String {
            task.id
        }
        var task: Task
        var userTask: UserTask?
    }
    
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
    
    @Published var business: Business
    
    @Published var journey: Journey
    
    @Published var businessUser: BusinessUser
    
    @Published var allTaskModels: [TaskModel] = []
    
    @Published var lateTaskModels: [TaskModel] = []
    
    @Published var dailyTaskModels: [TaskModel] = []
    
    @Published var nextTaskModels: [TaskModel] = []
    
    @Published var doneTaskModels: [TaskModel] = []
    
    @Published var chosenTaskModel: TaskModel?
    
    @Published var chosenEvent: Event?
    
    @Published var uncompletedTasksCount: Int = 0
    
    @Published var categories: [TaskCategory] = [
        TaskCategory(name: "Integração", colorName: "vermelho", systemImageName: "star"),
        TaskCategory(name: "Integração", colorName: "roxo", systemImageName: "lock"),
        TaskCategory(name: "Integração", colorName: "amarelo", systemImageName: "star"),
        TaskCategory(name: "Integração", colorName: "verde", systemImageName: "lock")
    ]
    
    @Published var selectedEvents: [Event] = []
    
    @Published var selectedDate: Date = Date()
    
    init(business: Business, journey: Journey, businessUser: BusinessUser) {
        self.business = business
        self.journey = journey
        self.businessUser = businessUser
    }
    
    func handleAppear() {
        self.allTasks = business.tasks.filter({ $0.journeyId == journey.id })
        self.userTasks = businessUser.userTasks
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
    
    func selectTaskModel(_ taskModel: TaskModel) {
        self.chosenTaskModel = taskModel
    }
    
    func unselectTask() {
        chosenTaskModel = nil
    }
    
    func checkTaskModel(_ taskModel: TaskModel, completion: (BusinessUser) -> ()) {
        if let index = self.allTaskModels.firstIndex(where: { $0.id == taskModel.id }) {
            if taskModel.userTask?.doneDate != nil {
                let userTask = UserTask(taskId: taskModel.task.id, journeyId: journey.id, doneDate: nil)
                allTaskModels[index] = TaskModel(task: allTaskModels[index].task, userTask: userTask)
                self.updateUserTask(userTask, completion: completion)
            } else {
                let userTask = UserTask(taskId: taskModel.task.id, journeyId: journey.id, doneDate: Date().timeIntervalSince1970)
                allTaskModels[index] = TaskModel(task: allTaskModels[index].task, userTask: userTask)
                self.updateUserTask(userTask, completion: completion)
            }
            separateTaskModels()
        }
    }
    
    private func updateUserTask(_ userTask: UserTask, completion: (BusinessUser) -> ()) {
        if let index = businessUser.userTasks.firstIndex(where: { $0.id == userTask.id }) {
            businessUser.userTasks[index] = userTask
        } else {
            businessUser.userTasks.append(userTask)
        }
        completion(businessUser)
    }
    
    func isTaskModelChecked(_ taskModel: TaskModel) -> Bool {
        if let userTask = taskModel.userTask {
            return userTask.doneDate != nil
        } else {
            return false
        }
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
        
        self.uncompletedTasksCount = dailyTaskModels.count + nextTaskModels.count
    }
    
    // MARK: - Event functions
    func selectEvent(_ event: Event) {
        self.chosenEvent = event
    }
    
    func unselectEvent() {
        chosenEvent = nil
    }
}
