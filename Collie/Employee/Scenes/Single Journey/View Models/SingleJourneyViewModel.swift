import Foundation

final class SingleJourneyViewModel: ObservableObject {
    
    @Published var journey: Journey
    @Published var chosenTask: Task?
    
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
    
    func removeTask(_ task: Task) {
        if let index = journey.tasks.firstIndex(where: {$0.id == task.id}) {
            self.journey.tasks.remove(at: index)
        }
    }
    
    func selectTask(_ task: Task) {
        self.chosenTask = task
    }
    
    func unselectTask() {
        chosenTask = nil
    }
}
