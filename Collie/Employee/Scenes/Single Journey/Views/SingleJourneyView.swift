import SwiftUI

struct SingleJourneyView: View {
    @ObservedObject var viewModel: SingleJourneyViewModel
    
    @State var editJourney = false
    @State var showAddNewTask = false
    
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
                
                
                HStack(spacing: 16){
                    VStack {
                        HStack {
                            Text("Tarefas")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.black)
                            
                            Spacer()
                            
                            Button {
                                showAddNewTask = true
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
                            }
                            .contentShape(Rectangle())
                            .buttonStyle(.plain)
                        }
                        
                        ScrollView(.vertical) {
                            ForEach(viewModel.journey.tasks) { task in
                                TaskView(
                                    task: task,
                                    handleTaskOpen: {
                                        viewModel.selectTask(task)
                                    }
                                )
                            }
                            
                            Spacer()
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    .frame(maxWidth: .infinity)
                    .background(Color.collieCinzaClaro)
                    .cornerRadius(8)
                    
                    VStack {
                        HStack {
                            Text("Calendário")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.black)
                            
                            Spacer()
                            
                            Button {
                                // TO DO
                            } label: {
                                HStack {
                                    Image(systemName: "plus")
                                    Text("Novo evento")
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
                        
                        Spacer()
                    }
                    .padding()
                    .frame(width: 500)
                    .background(Color.collieCinzaClaro)
                    .cornerRadius(8)
                }
                .padding(.top)
                
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
                        handleJourneyCreation: { journey in
                            
                        }
                    )
                    .frame(maxWidth: 800)
                }
            }
            
            if showAddNewTask {
                ZStack {
                    Color.black.opacity(0.5)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    CreateOrEditTaskView(
                        task: nil,
                        handleClose: {
                            withAnimation {
                                showAddNewTask = false
                            }
                        },
                        handleTaskCreation: { task in
                            viewModel.saveTask(task)
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
                        handleTaskCreation: { task in
                            viewModel.saveTask(task)
                        }
                    )
                    .frame(maxWidth: 800)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.collieBranco)
    }
}

struct SingleJourneyView_Previews: PreviewProvider {
    static var previews: some View {
        SingleJourneyView(
            viewModel: SingleJourneyViewModel(
                journey: Journey(
                    name: "Jornada iOS",
                    startDate: Date(),
                    description: "Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtituo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo",
                    imageURL: URL(fileURLWithPath: ""),
                    employees: [],
                    tasks: [
                        Task(name: "Falar com X pessoa", description: "", startDate: Date(), endDate: Date(), taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star")),
                        Task(name: "A", description: "", startDate: Date(), endDate: Date(),taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star")),
                        Task(name: "B", description: "", startDate: Date(), endDate: Date(),taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star")),
                        Task(name: "C", description: "", startDate: Date(), endDate: Date(),taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star")),
                        Task(name: "D", description: "", startDate: Date(), endDate: Date(),taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star")),
                        Task(name: "E", description: "", startDate: Date(), endDate: Date(),taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star")),
                        Task(name: "F", description: "", startDate: Date(), endDate: Date(),taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star")),
                        Task(name: "G", description: "", startDate: Date(), endDate: Date(),taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star")),
                        Task(name: "H", description: "", startDate: Date(), endDate: Date(),taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star")),
                        Task(name: "I", description: "", startDate: Date(), endDate: Date(),taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star")),
                        Task(name: "J", description: "", startDate: Date(), endDate: Date(),taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star"))
                    ],
                    managers: []
                )
            ),
            backAction: {
                
            }
        )
    }
}
