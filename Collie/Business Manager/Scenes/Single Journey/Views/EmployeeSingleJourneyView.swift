import SwiftUI

struct EmployeeSingleJourneyView: View {
    @EnvironmentObject var rootViewModel: RootViewModel
    @StateObject var viewModel: EmployeeSingleJourneyViewModel
    
    @State var editJourney = false
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
                    Image(systemName: "chevron.left")
                        .font(.system(size: 30, weight: .bold, design: .default))
                        .onTapGesture {
                            backAction()
                        }
                    
                    Text(viewModel.journey.name)
                        .font(.system(size: 40, weight: .bold, design: .default))
                    
                    Spacer()
                }
                .foregroundColor(.black)
                .padding(.bottom)
                
                Text(viewModel.journey.description)
                    .font(.system(size: 16, weight: .regular, design: .default))
                    .foregroundColor(.black)
                
                
                HStack(spacing: 16) {
                    VStack {
                        HStack {
                            Text("Tarefas")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.black)
                            
//                            HelpButton(handleTap: {
//
//                            })
                            
                            Spacer()
                            
                            .contentShape(Rectangle())
                            .buttonStyle(.plain)
                        }
                        
                        HStack {
                            Text("\(viewModel.uncompletedTasksCount) tarefas pendentes")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.black)
                            Spacer()
                        }
                        .padding(.vertical)
                        
                        ScrollView(.vertical) {
                            HStack {
                                Text("Tarefas do dia")
                                    .foregroundColor(.black)
                                    .font(.system(size: 18, weight: .semibold))
                                Spacer()
                                Image(systemName: showDailyTasks ? "chevron.up" : "chevron.down")
                            }
                            .padding(24)
                            .background(Color.collieBrancoFundo)
                            .cornerRadius(8)
                            .onTapGesture {
                                withAnimation {
                                    showDailyTasks.toggle()
                                }
                            }
                            
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
                            
                            HStack {
                                Text("Próximas tarefas")
                                    .foregroundColor(.black)
                                    .font(.system(size: 18, weight: .semibold))
                                Spacer()
                                Image(systemName: showNextTasks ? "chevron.up" : "chevron.down")
                            }
                            .padding(24)
                            .background(Color.collieBrancoFundo)
                            .cornerRadius(8)
                            .onTapGesture {
                                withAnimation {
                                    showNextTasks.toggle()
                                }
                            }
                            
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
                            
                            HStack {
                                Text("Tarefas feitas")
                                    .foregroundColor(.black)
                                    .font(.system(size: 18, weight: .semibold))
                                Spacer()
                                Image(systemName: showDoneTasks ? "chevron.up" : "chevron.down")
                            }
                            .padding(24)
                            .background(Color.collieBrancoFundo)
                            .cornerRadius(8)
                            .onTapGesture {
                                withAnimation {
                                    showDoneTasks.toggle()
                                }
                            }
                            
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
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.black)
                            
                            HelpButton(handleTap: {
                                
                            })
                            
                            Spacer()
                        }
                        
                        EmployeeEventsCalendarView(
                            selectedDate: $viewModel.selectedDate,
                            events: rootViewModel.businessSelected.events,
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
            .padding(.horizontal)
            .padding(.top, 32)
            .padding(.bottom)
            
            if editJourney {
                ZStack {
                    Color.black.opacity(0.5)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    CreateOrEditJourneyView(
                        journey: viewModel.journey,
                        handleClose: {
                            withAnimation {
                                editJourney = false
                            }
                        },
                        handleJourneySave: { journey in
                            viewModel.journey = journey
                        }
                    )
                    .frame(maxWidth: 800)
                }
            }
            
            if viewModel.chosenTaskModel != nil {
                ZStack {
                    Color.black.opacity(0.5)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    EmployeeTaskFullView(
                        userTask: viewModel.chosenTaskModel!.userTask!,
                        task: viewModel.chosenTaskModel!.task,
                        handleClose: {
                            viewModel.unselectTask()
                        },
                        handleCheckToggle: {
                            withAnimation {
                                viewModel.checkTaskModel(viewModel.chosenTaskModel!) { businessUser in
                                    rootViewModel.updateBusinessUser(businessUser)
                                }
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
