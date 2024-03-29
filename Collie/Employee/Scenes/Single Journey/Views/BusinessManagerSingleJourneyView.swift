import SwiftUI

struct BusinessManagerSingleJourneyView: View {
    @ObservedObject var viewModel: BusinessManagerSingleJourneyViewModel
    @ObservedObject var journeyListViewModel: BusinessJourneyListViewModel
    
    @State var editJourney = false
    @State var showTaskForm = false
    @State var showEventForm = false
    
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
                    
                    Button {
                        editJourney = true
                    } label: {
                        HStack {
                            Image(systemName: "square.and.pencil")
                            Text("Editar jornada")
                        }
                        .font(.system(size: 16, weight: .bold))
                        .padding(8)
                        .foregroundColor(.black)
                        .background(Color.white)
                        .cornerRadius(8)
                    }
                    .contentShape(Rectangle())
                    .buttonStyle(.plain)
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
                            
                            HelpButton(handleTap: {
                                // TO DO
                            })

                            Spacer()
                            
                            Button {
                                showTaskForm = true
                            } label: {
                                HStack {
                                    Image(systemName: "plus")
                                    Text("Nova tarefa")
                                }
                                .font(.system(size: 16, weight: .bold))
                                .padding(8)
                                .foregroundColor(.black)
                                .background(Color.white)
                                .cornerRadius(8)
                                .modifier(CustomBorder())
                            }
                            .contentShape(Rectangle())
                            .buttonStyle(.plain)
                        }
                        
                        ScrollView(.vertical) {
//                            ForEach(viewModel.journey.tasks) { task in
//                                BusinessManagerTaskView(
//                                    task: task,
//                                    handleTaskOpen: {
//                                        viewModel.selectTask(task)
//                                    },
//                                    handleTaskDuplicate: {
//                                        viewModel.duplicateTask(task)
//                                    }
//                                )
//                            }
//                            .padding(2)
                            
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
                                // TO DO
                            })
                            
                            Spacer()
                            
                            Button {
                                showEventForm = true
                            } label: {
                                HStack {
                                    Image(systemName: "calendar.badge.plus")
                                    Text("Novo evento")
                                }
                                .font(.system(size: 16, weight: .bold))
                                .padding(8)
                                .foregroundColor(.black)
                                .background(Color.white)
                                .cornerRadius(8)
                                .modifier(CustomBorder())
                            }
                            .contentShape(Rectangle())
                            .buttonStyle(.plain)
                            
                        }
                        
                        BusinessManagerEventsCalendarView(selectedDate: $viewModel.selectedDate, singleJourneyViewModel: self.viewModel) { event in
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
                            viewModel.saveTask(task)
                        },
                        handleTaskDeletion: { task in
                            viewModel.removeTask(task)
                            withAnimation {
                                showTaskForm = false
                            }
                        },
                        handleTaskDuplicate: { task in
                            viewModel.duplicateTask(task)
                            withAnimation {
                                showTaskForm = false
                            }
                        }
                    )
                    .frame(maxWidth: 800)
                }
            }
            
            if viewModel.chosenTask != nil {
                ZStack {
                    Color.black.opacity(0.5)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    CreateOrEditTaskView(
                        task: viewModel.chosenTask,
                        handleClose: {
                            withAnimation {
                                viewModel.unselectTask()
                            }
                        },
                        handleTaskSave: { task in
                            viewModel.saveTask(task)
                        },
                        handleTaskDeletion: { task in
                            viewModel.removeTask(task)
                            withAnimation {
                                viewModel.unselectTask()
                            }
                        },
                        handleTaskDuplicate: { task in
                            viewModel.duplicateTask(task)
                            viewModel.unselectTask()
                        }
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
                        handleEventDelete: { event in
                            viewModel.removeEvent(event)
                            withAnimation {
                                viewModel.unselectEvent()
                            }
                        },
                        handleEventDuplicate: { event in
                            viewModel.duplicateEvent(event)
                            withAnimation {
                                viewModel.unselectEvent()
                            }
                        }
                    )
                    .frame(maxWidth: 800)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.collieBrancoFundo)
    }
}

struct SingleJourneyView_Previews: PreviewProvider {
    static var previews: some View {
        BusinessManagerSingleJourneyView(
            viewModel: BusinessManagerSingleJourneyViewModel(
                journey: Journey(
                    name: "Jornada iOS",
                    description: "Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtituo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo",
                    imageURL: "",
                    startDate: Date(),
                    userIds: []
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
            journeyListViewModel: BusinessJourneyListViewModel(),
            backAction: {
                
            }
        )
    }
}
