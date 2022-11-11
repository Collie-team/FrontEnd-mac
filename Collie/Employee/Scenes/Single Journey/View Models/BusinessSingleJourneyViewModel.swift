import Foundation
import SwiftUI

final class BusinessSingleJourneyViewModel: ObservableObject {
    
    @Published var business: Business
    
    @Published var journey: Journey
    
    @Published var chosenTask: Task?
    
    @Published var chosenEvent: Event?
    
    @Published var chosenCategory: TaskCategory?
    
    @Published var categories: [TaskCategory] = []
    
    @Published var selectedEvents: [Event] = []
    
    @Published var selectedDate: Date = Date()
    
    init(business: Business, journey: Journey) {
        self.business = business
        self.journey = journey
    }
    
    // MARK: - Journey functions
    func saveJourney(_ journey: Journey, completion: (Business) -> ()) {
        if let index = self.business.journeys.firstIndex(where: { $0.id == journey.id }) {
            self.business.journeys[index] = journey
            self.journey = journey
            completion(business)
        }
        objectWillChange.send()
    }
    
    // MARK: - Category functions
    func saveCategory(_ taskCategory: TaskCategory, completion: (Business) -> ()) {
        if let index = self.business.categories.firstIndex(where: { $0.id == taskCategory.id }) {
            self.business.categories[index] = taskCategory
        } else {
            self.business.categories.append(taskCategory)
        }
        completion(business)
        objectWillChange.send()
    }
    
    func removeCategory(_ taskCategory: TaskCategory, completion: (Business) -> ()) {
        if let index = self.business.categories.firstIndex(where: {$0.id == taskCategory.id}) {
            self.business.categories.remove(at: index)
            
            // Remove category id from tasks with this category
            for i in 0..<self.business.tasks.count {
                if self.business.tasks[i].categoryId == taskCategory.id {
                    self.business.tasks[i].categoryId = nil
                }
            }
            
            completion(business)
        }
        objectWillChange.send()
    }
    
    func selectCategory(_ taskCategory: TaskCategory) {
        self.chosenCategory = taskCategory
    }
    
    func unselectCategory() {
        self.chosenCategory = nil
    }
    
    // MARK: - Task functions
    func saveTask(_ task: Task, completion: (Business) -> ()) {
        if let index = self.business.tasks.firstIndex(where: { $0.id == task.id }) {
            self.business.tasks[index] = task
        } else {
            self.business.tasks.append(task)
        }
        completion(business)
        objectWillChange.send()
    }
    
    func removeTask(_ task: Task, completion: (Business) -> ()) {
        if let index = self.business.tasks.firstIndex(where: {$0.id == task.id}) {
            self.business.tasks.remove(at: index)
            completion(business)
        }
        objectWillChange.send()
    }
    
    func duplicateTask(_ task: Task, completion: (Business) -> ()) {
        var duplicatedTask = task
        duplicatedTask.id = UUID().uuidString
        duplicatedTask.name = "Cópia de \(task.name)"
        self.business.tasks.append(duplicatedTask)
        completion(business)
        objectWillChange.send()
    }
    
    func selectTask(_ task: Task) {
        self.chosenTask = task
    }
    
    func unselectTask() {
        chosenTask = nil
    }
    
    // MARK: - Event functions
    func saveEvent(_ event: Event, completion: (Business) -> ()) {
        if let index = self.business.events.firstIndex(where: { $0.id == event.id }) {
            self.business.events[index] = event
        } else {
            self.business.events.append(event)
        }
        completion(self.business)
        objectWillChange.send()
    }
    
    func removeEvent(_ event: Event, completion: (Business) -> ()) {
        if let index = self.business.events.firstIndex(where: {$0.id == event.id}) {
            self.business.events.remove(at: index)
        }
        completion(self.business)
        objectWillChange.send()
    }
    
    func duplicateEvent(_ event: Event, completion: (Business) -> ()) {
        var duplicatedEvent = event
        duplicatedEvent.id = UUID().uuidString
        duplicatedEvent.name = "Cópia de \(event.name)"
        self.business.events.append(duplicatedEvent)
        completion(self.business)
        objectWillChange.send()
    }
    
    func selectEvent(_ event: Event) {
        self.chosenEvent = event
    }
    
    func unselectEvent() {
        chosenEvent = nil
    }
}
