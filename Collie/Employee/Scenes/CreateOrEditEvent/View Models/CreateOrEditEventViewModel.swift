import Foundation

final class CreateOrEditEventViewModel: ObservableObject {
    private let teamListService = TeamSubscriptionService()
    
    var eventId: String?
    
    @Published var eventName = ""
    
    @Published var startDate = Date()
    
    @Published var endDate = Date()
    
    @Published var eventLink = ""
    
    @Published var eventDescription = ""
    
    @Published var selectedCategory: TaskCategory?
    
    @Published var showUserList = false
    
    @Published var showCategoryList = false
    
    @Published var categoryList: [TaskCategory] = []
    
    @Published var userModelList: [UserModel] = []
    
    @Published var chosenUserModels: [UserModel] = []
    
    var currentBusiness: Business
    
    init(currentBusiness: Business) {
        self.currentBusiness = currentBusiness
        self.categoryList = currentBusiness.categories
    }
    
    func isButtonDisabled() -> Bool {
        eventName.isEmpty
    }
    
    func selectCategory(_ taskCategory: TaskCategory) {
        if let oldSelectedCategory = selectedCategory {
            categoryList.append(oldSelectedCategory)
        }
        
        selectedCategory = taskCategory
        
        if let index = categoryList.firstIndex(where: { $0.id == taskCategory.id }) {
            categoryList.remove(at: index)
        }
    }
    
    func handleEventSave(journeyId: String, completion: (Business) -> ()) {
        var updatedBusiness = currentBusiness
        
        let event = Event(
            id: eventId ?? UUID().uuidString,
            journeyId: journeyId,
            name: eventName,
            description: eventDescription,
            contentLink: eventLink,
            startDate: startDate,
            endDate: endDate,
            responsibleUserIds: [],
            categoryId: selectedCategory?.id ?? ""
        )
        
        if let eventIndex = updatedBusiness.events.firstIndex(where: {$0.id == eventId}) {
            updatedBusiness.events[eventIndex] = event
        } else {
            updatedBusiness.events.append(event)
        }
        
        completion(updatedBusiness)
    }
}
