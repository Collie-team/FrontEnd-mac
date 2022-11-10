import Foundation
import SwiftUI

final class BusinessSingleJourneyViewModel: ObservableObject {
    
    @Published var business: Business
    
    @Published var journey: Journey
    
    @Published var chosenTask: Task?
    
    @Published var chosenEvent: Event?
    
    @Published var categories: [TaskCategory] = [
        TaskCategory(name: "Integração", colorName: "vermelho", systemImageName: "star"),
        TaskCategory(name: "Integração", colorName: "roxo", systemImageName: "lock"),
        TaskCategory(name: "Integração", colorName: "amarelo", systemImageName: "star"),
        TaskCategory(name: "Integração", colorName: "verde", systemImageName: "lock")
    ]
    
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
