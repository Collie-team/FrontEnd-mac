import SwiftUI

struct EmployeeSingleJourneyView: View {
    @EnvironmentObject var rootViewModel: RootViewModel
    @StateObject var viewModel: EmployeeSingleJourneyViewModel
    
    @State var showTaskForm = false
    @State var showEventForm = false
    @State var showDailyTasks = true
    @State var showNextTasks = false
    @State var showDoneTasks = true
    
    var backAction: () -> ()
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 16) {
                HStack(spacing: 16) {
                    IconButton(imageSystemName: "chevron.left") {
                        backAction()
                    }
                    
                    Text(viewModel.journey.name)
                        .collieFont(textStyle: .largeTitle)
                    
                    Spacer()
                }
                .foregroundColor(.black)
                .padding(.bottom)
                
                Text(viewModel.journey.description)
                    .collieFont(textStyle: .regularText)
                    .foregroundColor(.black)
                
                
                HStack(spacing: 16) {
                    VStack {
                        HStack {
                            Text("Tarefas")
                                .collieFont(textStyle: .title)
                                .foregroundColor(.black)
                            
                            Spacer()
                            
                            .contentShape(Rectangle())
                            .buttonStyle(.plain)
                        }
                        
                        HStack {
                            Text("\(viewModel.uncompletedTasksCount) tarefas pendentes")
                                .collieFont(textStyle: .subtitle)
                                .foregroundColor(.black)
                            Spacer()
                        }
                        .padding(.vertical)
                        
                        ScrollView(.vertical) {
                            EmployeeTaskSection(
                                sectionTitle: "Tarefas do dia",
                                systemImageName: "note.text",
                                shouldShowTasks: $showDailyTasks
                            )
                            
                            if showDailyTasks {
                                ForEach($viewModel.dailyTaskModels) { $taskModel in
                                    EmployeeTaskView(
                                        task: taskModel.task,
                                        userTask: taskModel.userTask ?? UserTask(taskId: "", journeyId: ""),
                                        checked: viewModel.isTaskModelChecked(taskModel),
                                        isLate: viewModel.isTaskModelLate(taskModel),
                                        handleTaskOpen: {
                                            viewModel.selectTaskModel(taskModel)
                                        },
                                        handleTaskCheckToggle: {
                                            viewModel.checkTaskModel(taskModel) { businessUser in
                                                rootViewModel.updateBusinessUser(businessUser)
                                            }
                                        }
                                    )
                                }
                                .padding(2)
                            }
                            
                            EmployeeTaskSection(
                                sectionTitle: "Próximas tarefas",
                                systemImageName: "list.bullet",
                                shouldShowTasks: $showNextTasks
                            )
                            
                            if showNextTasks {
                                ForEach($viewModel.nextTaskModels) { $taskModel in
                                    EmployeeTaskView(
                                        task: taskModel.task,
                                        userTask: taskModel.userTask ?? UserTask(taskId: "", journeyId: ""),
                                        checked: viewModel.isTaskModelChecked(taskModel),
                                        isLate: viewModel.isTaskModelLate(taskModel),
                                        handleTaskOpen: {
                                            viewModel.selectTaskModel(taskModel)
                                        },
                                        handleTaskCheckToggle: {
                                            viewModel.checkTaskModel(taskModel) { businessUser in
                                                rootViewModel.updateBusinessUser(businessUser)
                                            }
                                        }
                                    )
                                }
                                .padding(2)
                            }
                            
                            EmployeeTaskSection(
                                sectionTitle: "Tarefas feitas",
                                systemImageName: "sparkles",
                                shouldShowTasks: $showDoneTasks
                            )
                            
                            if showDoneTasks {
                                ForEach($viewModel.doneTaskModels) { $taskModel in
                                    EmployeeTaskView(
                                        task: taskModel.task,
                                        userTask: taskModel.userTask ?? UserTask(taskId: "", journeyId: ""),
                                        checked: viewModel.isTaskModelChecked(taskModel),
                                        isLate: viewModel.isTaskModelLate(taskModel),
                                        handleTaskOpen: {
                                            viewModel.selectTaskModel(taskModel)
                                        },
                                        handleTaskCheckToggle: {
                                            viewModel.checkTaskModel(taskModel) { businessUser in
                                                rootViewModel.updateBusinessUser(businessUser)
                                            }
                                        }
                                    )
                                }
                                .padding(2)
                            }
                            
                            Spacer()
                        }
                    }
                    .padding(.horizontal, 32)
                    .padding(.top, 32)
                    .frame(maxWidth: .infinity)
                    .background(Color.collieBrancoFundoSecoes)
                    .cornerRadius(8)
                    
                    VStack {
                        HStack {
                            Text("Eventos")
                                .collieFont(textStyle: .title)
                                .foregroundColor(.black)
                            
                            Spacer()
                        }
                        
                        EmployeeEventsCalendarView(
                            selectedDate: $viewModel.selectedDate,
                            events: rootViewModel.businessSelected.events.filter({ $0.journeyId == self.viewModel.journey.id }),
                            employeeSingleJourneyViewModel: self.viewModel
                        ) { event in
                                viewModel.selectEvent(event)
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal, 32)
                    .padding(.top, 32)
                    .frame(width: 500)
                    .background(Color.collieBrancoFundoSecoes)
                    .cornerRadius(8)
                }
                
                Spacer()
            }
            .padding(.horizontal, 32)
            .padding(.top, 32)
            .padding(.bottom)
            
            if let chosenTaskModel = viewModel.chosenTaskModel {
                ZStack {
                    Color.black.opacity(0.5)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    EmployeeTaskFullView(
                        employeeSingleJourneyViewModel: self.viewModel,
                        category: rootViewModel.getCategory(categoryId: chosenTaskModel.task.categoryId ?? ""),
                        handleClose: {
                            viewModel.unselectTask()
                        },
                        handleCheckToggle: {
                            viewModel.checkTaskModel(chosenTaskModel) { businessUser in
                                rootViewModel.updateBusinessUser(businessUser)
                            }
                        }
                    )
                    .frame(maxWidth: 800)
                }
            }
            
            if let event = viewModel.chosenEvent {
                ZStack {
                    Color.black.opacity(0.5)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    EmployeeEventFullView(event: event, handleClose: {
                        withAnimation {
                            viewModel.unselectEvent()
                        }
                    })
                    .frame(maxWidth: 800)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.collieBrancoFundo)
        .onAppear {
            viewModel.handleAppear()
        }
    }
}

struct EmployeeSingleJourneyView_Previews: PreviewProvider {
    static var previews: some View {
        EmployeeSingleJourneyView(
            viewModel: EmployeeSingleJourneyViewModel(
                business: Business(
                    name: "Aurea",
                    description: "",
                    journeys: [],
                    tasks: [],
                    categories: [],
                    events: []
                ),
                journey: Journey(
                    name: "Jornada iOS",
                    description: "Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtituo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo",
                    imageURL: "",
                    startDate: Date(),
                    userIds: []
                ),
                businessUser: BusinessUser(userId: "SS", businessId: "ffaasfsfa", role: .manager, userTasks: [])
            ),
            backAction: {}
        )
    }
}
