import SwiftUI

struct BusinessSingleJourneyView: View {
    @EnvironmentObject var rootViewModel: RootViewModel
    @StateObject var viewModel: BusinessSingleJourneyViewModel
    
    @State var editJourney = false
    @State var showTaskForm = false
    @State var showCategoryForm = false
    @State var showEventForm = false
    @State var showTasksHint = false
    @State var showEventsHint = false
    
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
                                showTasksHint = true
                            })
                            .popover(isPresented: $showTasksHint, arrowEdge: .bottom) {
                                HelpView(title: "O que é uma tarefa?", subtitle: "São as atividades que você deseja que o colaborador realize durante o expediente de forma mais ativa, apenas possui uma data máxima, a qual pode ser realizada a qualquer momento dentro do prazo.")
                            }

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
                                .frame(height: 45)
                                .cornerRadius(8)
                                .modifier(CustomBorder())
                            }
                            .contentShape(Rectangle())
                            .buttonStyle(.plain)
                            
                            Button {
                                showCategoryForm = true
                            } label: {
                                HStack {
                                    Image(systemName: "tag")
                                    Text("Nova categoria")
                                }
                                .font(.system(size: 16, weight: .bold))
                                .padding(8)
                                .foregroundColor(.black)
                                .background(Color.white)
                                .frame(height: 45)
                                .cornerRadius(8)
                                .modifier(CustomBorder())
                            }
                            .contentShape(Rectangle())
                            .buttonStyle(.plain)
                        }
                        
                        ScrollView(.vertical) {
                            ForEach(rootViewModel.businessSelected.categories, id: \.self) { category in
                                CategoryCard(category: category) {
                                    viewModel.selectCategory(category)
                                }
                                
                                ForEach(viewModel.business.tasks.filter({ $0.journeyId == viewModel.journey.id && $0.categoryId == category.id })) { task in
                                    BusinessTaskView(
                                        task: task,
                                        category: rootViewModel.getCategory(categoryId: task.categoryId ?? ""),
                                        handleTaskOpen: {
                                            viewModel.selectTask(task)
                                        },
                                        handleTaskDuplicate: {
                                            viewModel.duplicateTask(task) { business in
                                                rootViewModel.updateBusiness(business, replaceBusiness: false)
                                            }
                                        }
                                    )
                                }
                                .padding(2)
                            }
                            
                            if !(viewModel.business.tasks.filter({ $0.journeyId == viewModel.journey.id && $0.categoryId == nil})).isEmpty {
                                HStack(spacing: 16) {
                                    Text("Sem categoria")
                                    Spacer()
                                }
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.white)
                                .padding(.vertical, 12)
                                .padding(.horizontal, 16)
                                .background(Color.collieRoxoClaro)
                                .cornerRadius(8)
                                
                                ForEach(viewModel.business.tasks.filter({ $0.journeyId == viewModel.journey.id && $0.categoryId == nil })) { task in
                                    BusinessTaskView(
                                        task: task,
                                        category: rootViewModel.getCategory(categoryId: task.categoryId ?? ""),
                                        handleTaskOpen: {
                                            viewModel.selectTask(task)
                                        },
                                        handleTaskDuplicate: {
                                            viewModel.duplicateTask(task) { business in
                                                rootViewModel.updateBusiness(business, replaceBusiness: false)
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
                                showEventsHint = true
                            })
                            .popover(isPresented: $showEventsHint, arrowEdge: .bottom) {
                                HelpView(title: "O que é um evento?", subtitle: "São encontros que você deseja que o colaborador, envolvem palestras ou conversas com o time. Eles tem dia e hora marcada para que um grupo se encontrem.")
                            }
                            
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
                                .frame(height: 45)
                                .cornerRadius(8)
                                .modifier(CustomBorder())
                            }
                            .contentShape(Rectangle())
                            .buttonStyle(.plain)
                            
                        }
                        
                        BusinessEventsCalendarView(
                            selectedDate: $viewModel.selectedDate,
                            events: rootViewModel.businessSelected.events.filter({ $0.journeyId == self.viewModel.journey.id}),
                            rootViewModel: rootViewModel,
                            businessSingleJourneyViewModel: self.viewModel
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
                            viewModel.saveJourney(journey) { business in
                                rootViewModel.updateBusiness(business, replaceBusiness: false)
                            }
                        }
                    )
                    .frame(maxWidth: 800)
                }
            }
            
            if showCategoryForm {
                ZStack {
                    Color.black.opacity(0.5)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    CreateOrEditCategoryView(
                        category: nil,
                        handleClose: {
                            withAnimation {
                                showCategoryForm = false
                            }
                        },
                        handleCategorySave: { taskCategory in
                            viewModel.saveCategory(taskCategory) { business in
                                rootViewModel.updateBusiness(business, replaceBusiness: false)
                            }
                        },
                        handleCategoryDelete: { taskCategory in
                            viewModel.removeCategory(taskCategory) { business in
                                rootViewModel.updateBusiness(business, replaceBusiness: true)
                            }
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
                        viewModel: CreateOrEditTaskViewModel(categoryList: rootViewModel.businessSelected.categories),
                        journeyId: viewModel.journey.id,
                        task: nil,
                        category: rootViewModel.getCategory(categoryId: ""),
                        handleClose: {
                            withAnimation {
                                showTaskForm = false
                            }
                        },
                        handleTaskSave: { task in
                            viewModel.saveTask(task) { business in
                                rootViewModel.updateBusiness(business, replaceBusiness: false)
                            }
                        },
                        handleTaskDeletion: { task in
                            viewModel.removeTask(task) { business in
                                rootViewModel.updateBusiness(business, replaceBusiness: true)
                            }
                            withAnimation {
                                showTaskForm = false
                            }
                        },
                        handleTaskDuplicate: { task in
                            viewModel.duplicateTask(task) { business in
                                rootViewModel.updateBusiness(business, replaceBusiness: false)
                            }
                            withAnimation {
                                showTaskForm = false
                            }
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
                        viewModel: CreateOrEditEventViewModel(categoryList: rootViewModel.businessSelected.categories),
                        event: nil,
                        category: rootViewModel.getCategory(categoryId: ""),
                        journeyId: viewModel.journey.id,
                        handleClose: {
                            withAnimation {
                                showEventForm = false
                            }
                        },
                        handleEventSave: { event in
                            viewModel.saveEvent(event) { business in
                                rootViewModel.updateBusiness(business, replaceBusiness: false)
                            }
                        },
                        handleEventDelete: { _ in },
                        handleEventDuplicate: { _ in }
                    )
                    .frame(maxWidth: 800)
                }
            }
            
            if let chosenCategory = viewModel.chosenCategory {
                ZStack {
                    Color.black.opacity(0.5)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    CreateOrEditCategoryView(
                        category: chosenCategory,
                        handleClose: {
                            withAnimation {
                                viewModel.unselectCategory()
                            }
                        },
                        handleCategorySave: { taskCategory in
                            viewModel.saveCategory(taskCategory) { business in
                                rootViewModel.updateBusiness(business, replaceBusiness: false)
                            }
                        },
                        handleCategoryDelete: { taskCategory in
                            viewModel.removeCategory(taskCategory) { business in
                                rootViewModel.updateBusiness(business, replaceBusiness: true)
                            }
                            withAnimation {
                                viewModel.unselectCategory()
                            }
                        }
                    )
                    .frame(maxWidth: 800)
                }
            }
            
            if let chosenTask = viewModel.chosenTask {
                ZStack {
                    Color.black.opacity(0.5)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    CreateOrEditTaskView(
                        viewModel: CreateOrEditTaskViewModel(categoryList: rootViewModel.businessSelected.categories),
                        journeyId: viewModel.journey.id,
                        task: chosenTask,
                        category: rootViewModel.getCategory(categoryId: chosenTask.categoryId ?? ""),
                        handleClose: {
                            withAnimation {
                                viewModel.unselectTask()
                            }
                        },
                        handleTaskSave: { task in
                            viewModel.saveTask(task) { business in
                                rootViewModel.updateBusiness(business, replaceBusiness: false)
                            }
                        },
                        handleTaskDeletion: { task in
                            viewModel.removeTask(task) { business in
                                rootViewModel.updateBusiness(business, replaceBusiness: true)
                            }
                            withAnimation {
                                viewModel.unselectTask()
                            }
                        },
                        handleTaskDuplicate: { task in
                            viewModel.duplicateTask(task) { business in
                                rootViewModel.updateBusiness(business, replaceBusiness: false)
                            }
                            viewModel.unselectTask()
                        }
                    )
                    .frame(maxWidth: 800)
                }
            }
            
            if let chosenEvent = viewModel.chosenEvent {
                ZStack {
                    Color.black.opacity(0.5)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                    CreateOrEditEventView(
                        viewModel: CreateOrEditEventViewModel(categoryList: rootViewModel.businessSelected.categories),
                        event: chosenEvent,
                        category: rootViewModel.getCategory(categoryId: chosenEvent.categoryId ?? ""),
                        journeyId: viewModel.journey.id,
                        handleClose: {
                            withAnimation {
                                viewModel.unselectEvent()
                            }
                        },
                        handleEventSave: { event in
                            viewModel.saveEvent(event) { business in
                                rootViewModel.updateBusiness(business, replaceBusiness: false)
                            }
                        },
                        handleEventDelete: { event in
                            viewModel.removeEvent(event) { business in
                                rootViewModel.updateBusiness(business, replaceBusiness: true)
                                withAnimation {
                                    viewModel.unselectEvent()
                                }
                            }
                        },
                        handleEventDuplicate: { event in
                            viewModel.duplicateEvent(event) { business in
                                rootViewModel.updateBusiness(business, replaceBusiness: false)
                            }
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
