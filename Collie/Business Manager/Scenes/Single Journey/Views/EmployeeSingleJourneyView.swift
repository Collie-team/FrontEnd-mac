import SwiftUI

struct EmployeeSingleJourneyView: View {
    @ObservedObject var viewModel: EmployeeSingleJourneyViewModel
    @ObservedObject var employeeJourneyListViewModel: EmployeeJourneyListViewModel
    
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
                            
                            Spacer()
                            
                            .contentShape(Rectangle())
                            .buttonStyle(.plain)
                        }
                        
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
                                        handleTaskOpen: {
                                            viewModel.selectTaskModel(taskModel)
                                        },
                                        handleTaskCheckToggle: {
                                            viewModel.checkTaskModel(taskModel)
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
                                        handleTaskOpen: {
                                            viewModel.selectTaskModel(taskModel)
                                        },
                                        handleTaskCheckToggle: {
                                            viewModel.checkTaskModel(taskModel)
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
                                        handleTaskOpen: {
                                            viewModel.selectTaskModel(taskModel)
                                        },
                                        handleTaskCheckToggle: {
                                            viewModel.checkTaskModel(taskModel)
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
                            Text("Calendário")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.black)
                            
                            Spacer()
                        }
                        
                        EmployeeEventsCalendarView(selectedDate: $viewModel.selectedDate, employeeSingleJourneyViewModel: self.viewModel) { event in
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
            
            if showTaskForm {
                ZStack {
                    Color.black.opacity(0.5)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    CreateOrEditTaskView(
                        task: nil,
                        handleClose: {
                            withAnimation {
                                showTaskForm = false
                            }
                        },
                        handleTaskSave: { task in
//                            viewModel.saveTask(task)
                        },
                        handleTaskDeletion: { _ in },
                        handleTaskDuplicate: { _ in }
                    )
                    .frame(maxWidth: 800)
                }
            }
            
            if viewModel.chosenTaskModel != nil {
                ZStack {
                    Color.black.opacity(0.5)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    CreateOrEditTaskView(
                        task: viewModel.chosenTaskModel?.task,
                        handleClose: {
                            withAnimation {
                                viewModel.unselectTask()
                            }
                        },
                        handleTaskSave: { task in
//                            viewModel.saveTask(task)
                        },
                        handleTaskDeletion: { _ in },
                        handleTaskDuplicate: { _ in }
                    )
                    .frame(maxWidth: 800)
                }
            }
            
            if showEventForm {
                ZStack {
                    Color.black.opacity(0.5)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                    CreateOrEditEventView(
                        event: nil,
                        handleClose: {
                            withAnimation {
                                showEventForm = false
                            }
                        },
                        handleEventSave: { event in
                            viewModel.saveEvent(event)
                        },
                        handleEventDelete: { _ in },
                        handleEventDuplicate: { _ in }
                    )
                    .frame(maxWidth: 800)
                }
            }
            
            if viewModel.chosenEvent != nil {
                ZStack {
                    Color.black.opacity(0.5)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                    CreateOrEditEventView(
                        event: viewModel.chosenEvent,
                        handleClose: {
                            withAnimation {
                                viewModel.unselectEvent()
                            }
                        },
                        handleEventSave: { event in
                            viewModel.saveEvent(event)
                        },
                        handleEventDelete: { _ in },
                        handleEventDuplicate: { _ in }
                    )
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
                journey: Journey(
                    name: "Jornada iOS",
                    description: "Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtituo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo",
                    imageURL: URL(fileURLWithPath: ""),
                    startDate: Date()
//                    employees: [],
//                    tasks: [
//                        Task(name: "Falar com X pessoa", description: "", startDate: Date(), endDate: Date(), taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star")),
//                        Task(name: "A", description: "", startDate: Date(), endDate: Date(),taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star")),
//                        Task(name: "B", description: "", startDate: Date(), endDate: Date(),taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star")),
//                        Task(name: "C", description: "", startDate: Date(), endDate: Date(),taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star")),
//                        Task(name: "D", description: "", startDate: Date(), endDate: Date(),taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star")),
//                        Task(name: "E", description: "", startDate: Date(), endDate: Date(),taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star")),
//                        Task(name: "F", description: "", startDate: Date(), endDate: Date(),taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star")),
//                        Task(name: "G", description: "", startDate: Date(), endDate: Date(),taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star")),
//                        Task(name: "H", description: "", startDate: Date(), endDate: Date(),taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star")),
//                        Task(name: "I", description: "", startDate: Date(), endDate: Date(),taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star")),
//                        Task(name: "J", description: "", startDate: Date(), endDate: Date(),taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star"))
//                    ],
//                    events: [],
//                    managers: []
                )
            ),
            employeeJourneyListViewModel: EmployeeJourneyListViewModel(),
            backAction: {
                
            }
        )
    }
}
