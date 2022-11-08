//
//  RootViewModel.swift
//  Collie
//
//  Created by Pablo Penas on 18/10/22.
//

import SwiftUI

enum NavigationState {
    case authentication
    case workspace
    case manager
    case employee
    case managerOnboarding
    case employeeOnboarding
}

final class RootViewModel: ObservableObject {
    private let businessSubscriptionService = BusinessSubscriptionService()
    @Published var navigationState: NavigationState = .authentication
    
    
    @Published var businessSelected: Business {
        didSet {
            print(businessSelected)
        }
    }
    
    var currentUser: UserModel = UserModel(id: "", name: "", email: "", jobDescription: "", personalDescription: "", imageURL: "")
    var currentBusinessUser: BusinessUser?
    
    var authenticationToken: String?
    var availableBusiness: [Business] = []
    var availableBusinessUsers: [BusinessUser] = []
    
    init() {
        self.businessSelected = Business(
            id: "",
            name: "",
            description: "",
            journeys: [
                Journey(id: "teste1", name: "Jornada iOS", description: "Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição ", imageURL: "", startDate: Date()),
                Journey(id: "teste2", name: "Jornada de Design", description: "Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição Descrição ", imageURL: "", startDate: Date())
            ],
            tasks: [
                Task(id: "123", journeyId: "teste1", name: "Falar com X pessoa", description: "", taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star"), startDate: Date(), endDate: Date()),
                Task(id: "124", journeyId: "teste1", name: "A", description: "", taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star"), startDate: Date(), endDate: Date()),
                Task(id: "125", journeyId: "teste1", name: "B", description: "", taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star"), startDate: Date(), endDate: Date()),
                Task(id: "126", journeyId: "teste1", name: "C", description: "", taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star"), startDate: Date(), endDate: Date()),
                Task(id: "127", journeyId: "teste1", name: "D", description: "", taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star"), startDate: Date(), endDate: Date()),
                Task(id: "128", journeyId: "teste1", name: "E", description: "", taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star"), startDate: Date(), endDate: Date()),
                Task(id: "129", journeyId: "teste1", name: "F", description: "", taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star"), startDate: Date(), endDate: Date()),
                Task(id: "130", journeyId: "teste1", name: "G", description: "", taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star"), startDate: Date(), endDate: Date()),
                Task(id: "131", journeyId: "teste1", name: "H", description: "", taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star"), startDate: Date(), endDate: Date()),
                Task(id: "132", journeyId: "teste1", name: "I", description: "", taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star"), startDate: Date(), endDate: Date()),
                Task(id: "133", journeyId: "teste1", name: "J", description: "", taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star"), startDate: Date(), endDate: Date()),
                Task(id: "134", journeyId: "teste2", name: "K", description: "", taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star"), startDate: Date(), endDate: Date())
            ], events: [
                Event(journeyId: "teste1", name: "Workshop do foda-se", description: "", contentLink: "", startDate: Date(), endDate: Date(), responsibleUserIds: []),
                Event(journeyId: "teste1", name: "Workshop III", description: "", contentLink: "", startDate: Date(), endDate: Date(), responsibleUserIds: []),
                Event(journeyId: "teste1", name: "Workshop VV", description: "", contentLink: "", startDate: Date(), endDate: Date(), responsibleUserIds: []),
                Event(journeyId: "teste1", name: "Workshop SS", description: "", contentLink: "", startDate: Date(), endDate: Date(), responsibleUserIds: []),
                Event(journeyId: "teste2", name: "Workshop kfanklasn", description: "", contentLink: "", startDate: Date(), endDate: Date(), responsibleUserIds: []),
                Event(journeyId: "teste2", name: "Workshop asdnsajdnkjasdbjksadb", description: "", contentLink: "", startDate: Date(), endDate: Date(), responsibleUserIds: [])
            ])
    }
    
    func handleAuthentication(user: UserModel, authToken: String) -> () {
        self.authenticationToken = authToken
        self.currentUser = user
        businessSubscriptionService.fetchBusiness(user: self.currentUser, authenticationToken: self.authenticationToken!) { business, businessUser  in
            print(business)
            self.availableBusiness = business
            self.availableBusinessUsers = businessUser
            self.navigationState = .workspace
        }
    }
    
    func createWorkspace(workspaceName: String, _ completion: @escaping (Business) -> ()) {
        businessSubscriptionService.createBusiness(user: currentUser, businessName: workspaceName, authenticationToken: authenticationToken!) { business, businessUser  in
            self.currentBusinessUser = businessUser
            completion(business)
        }
    }
    
    func handleWorkspaceSelection(business: Business) {
        businessSelected = business
        if currentBusinessUser != nil {
            redirectBasedOnRole()
        } else {
            currentBusinessUser = availableBusinessUsers.first(where: {$0.businessId == business.id})
            redirectBasedOnRole()
        }
    }
    
    func redirectBasedOnRole() {
        // AQUI
        if currentBusinessUser!.role == .admin || currentBusinessUser!.role == .manager {
            let isManagerOnboardingDone = OnboardingStorageService.shared.isOnboardingDone(onboardingType: .businessManager)
            if isManagerOnboardingDone {
                self.navigationState = .manager
            } else {
                self.navigationState = .managerOnboarding
            }
        } else {
            let isEmployeeOnboardingDone = OnboardingStorageService.shared.isOnboardingDone(onboardingType: .employee)
            if isEmployeeOnboardingDone {
                self.navigationState = .employee
            } else {
                self.navigationState = .employeeOnboarding
            }
        }
    }
    
    func updateBusiness(_ business: Business) {
        
    }
    
    func refreshBusiness(_ business: Business) {
        
    }
    
    func addNewJourney(_ journey: Journey, completion: () -> ()) {
        businessSelected.journeys.append(journey)
        completion()
        objectWillChange.send()
    }
    
    func saveJourney(_ journey: Journey) {
        if let index = businessSelected.journeys.firstIndex(where: { $0.id == journey.id }) {
            businessSelected.journeys[index] = journey
            objectWillChange.send()
        }
    }
    
    func addNewEvent(_ event: Event) {
        businessSelected.events.append(event)
        objectWillChange.send()
    }
    
    func saveEvent(_ event: Event) {
        if let index = businessSelected.events.firstIndex(where: { $0.id == event.id }) {
            businessSelected.events[index] = event
            objectWillChange.send()
        }
    }
    
    func addNewTask(_ task: Task) {
        businessSelected.tasks.append(task)
        objectWillChange.send()
    }
    
    func saveTask(_ task: Task) {
        if let index = businessSelected.tasks.firstIndex(where: { $0.id == task.id }) {
            businessSelected.tasks[index] = task
            objectWillChange.send()
        }
    }
}
