import SwiftUI
import SDWebImageSwiftUI

struct InspectView: View {
    @EnvironmentObject var rootViewModel: RootViewModel
    @EnvironmentObject var businessSidebarViewModel: BusinessSidebarViewModel
    @ObservedObject var viewModel: InspectViewModel

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
                    if rootViewModel.inspectingUser!.imageURL != "", let url = URL(string: rootViewModel.inspectingUser!.imageURL) {
                        AnimatedImage(url: url)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 75, height: 75)
                            .cornerRadius(40)
                            .padding(.trailing)
                    } else {
                        ZStack {
                            Circle()
                                .fill(Color.collieRoxo)
                                .frame(width: 75, height: 75)
                            Text(getNameLetters(fullName: viewModel.user.name))
                                .collieFont(textStyle: .largeTitle)
                                .foregroundColor(.white)
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        Text(viewModel.user.name)
                            .collieFont(textStyle: .largeTitle)
                        Text(viewModel.journey?.name ?? "Sem jornada")
                            .collieFont(textStyle: .subtitle, textSize: 16)
                    }
                    
                    Spacer()
                    
                    TopUserProfileIcon(navigateToProfileAction: {
                        if let profileItem = businessSidebarViewModel.sidebarItens.first(where: { $0.option == .profile}) {
                            businessSidebarViewModel.selectedItem = profileItem
                        }
                    })
                        .environmentObject(rootViewModel)
                }
                .foregroundColor(.black)
                .padding(.bottom)
                
                if viewModel.journey != nil {
                    journeyView
                } else {
                    emptyJourneyView
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
                    InspectEmployeeTaskFullView(
                        inspectViewModel: self.viewModel,
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
    
    var emptyJourneyView: some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                Text("Sem jornadas! Esse usuário ainda não está em nenhuma jornada de onboarding, que tal adicioná-lo na edição de alguma jornada?")
                    .collieFont(textStyle: .subtitle, textSize: 20)
                Spacer()
            }
            Spacer()
        }
        .background(Color.collieBrancoFundoSecoes)
        .cornerRadius(8)
    }
    
    var journeyView: some View {
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
                                handleTaskCheckToggle: {}
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
            
//            VStack {
//                HStack {
//                    Text("Eventos")
//                        .collieFont(textStyle: .title)
//                        .foregroundColor(.black)
//
//                    Spacer()
//                }
//
////                        EmployeeEventsCalendarView(
////                            selectedDate: $viewModel.selectedDate,
////                            events: rootViewModel.businessSelected.events.filter({ $0.journeyId == self.viewModel.journey.id }),
////                            employeeSingleJourneyViewModel: self.viewModel
////                        ) { event in
////                                viewModel.selectEvent(event)
////                        }
//
//                Spacer()
//            }
//            .padding(.horizontal, 32)
//            .padding(.top, 32)
//            .frame(width: 500)
//            .background(Color.collieBrancoFundoSecoes)
//            .cornerRadius(8)
        }
    }
    
    func getNameLetters(fullName: String) -> String {
        let firstLetter = fullName.components(separatedBy: " ")[0].uppercased().prefix(1)
        let secondLetter = fullName.components(separatedBy: " ").count > 1 ? fullName.components(separatedBy: " ")[1].uppercased().prefix(1) : ""
        return (String(firstLetter + secondLetter))
    }
}

