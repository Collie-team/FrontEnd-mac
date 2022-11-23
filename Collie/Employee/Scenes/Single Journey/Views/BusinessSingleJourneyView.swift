import SwiftUI

struct BusinessSingleJourneyView: View {
    @EnvironmentObject var rootViewModel: RootViewModel
    @EnvironmentObject var businessSidebarViewModel: BusinessSidebarViewModel
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
                    IconButton(imageSystemName: "chevron.left") {
                        backAction()
                    }
                    
                    Text(viewModel.journey.name)
                        .collieFont(textStyle: .largeTitle)
                    
                    Spacer()
                    
                    DefaultButtonWithLeftIcon(
                        label: "Editar jornada",
                        systemImageName: "square.and.pencil",
                        onTap: {
                            editJourney = true
                        }
                    )
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
                            
                            HelpButton(handleTap: {
                                showTasksHint = true
                            })
                            .popover(isPresented: $showTasksHint, arrowEdge: .bottom) {
                                HelpView(title: "O que é uma tarefa?", subtitle: "São as atividades que você deseja que o colaborador realize durante o expediente de forma mais ativa, apenas possui uma data máxima, a qual pode ser realizada a qualquer momento dentro do prazo.")
                            }

                            Spacer()
                            
                            DefaultButtonWithLeftIcon(
                                label: "Nova tarefa",
                                systemImageName: "plus",
                                onTap: {
                                    showTaskForm = true
                                }
                            )
                            
                            DefaultButtonWithLeftIcon(
                                label: "Nova categoria",
                                systemImageName: "tag",
                                onTap: {
                                    showCategoryForm = true
                                }
                            )
                        }
                        
                        ScrollView(.vertical) {
                            if rootViewModel.businessSelected.tasks.filter({ $0.journeyId == viewModel.journey.id }).isEmpty {
                                VStack {
                                    Spacer()
                                    Image("noTasksFound")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(maxWidth: 175)
                                        .padding(.bottom)
                                    
                                    Text("Nada por aqui")
                                        .collieFont(textStyle: .regularText)
                                        .foregroundColor(Color.collieLilas)
                                    
                                    Text("Crie uma nova tarefa!")
                                        .collieFont(textStyle: .smallTitle)
                                        .foregroundColor(Color.collieLilas)
                                        .multilineTextAlignment(.center)
                                    Spacer()
                                }
                                .padding()
                            } else {
                                VStack {
                                    ForEach(rootViewModel.businessSelected.categories, id: \.self) { category in
                                        if !rootViewModel.businessSelected.tasks.filter({ $0.journeyId == viewModel.journey.id && $0.categoryId == category.id }).isEmpty {
                                            CategoryCard(category: category) {
                                                viewModel.selectCategory(category)
                                            }
                                        }
                                        
                                        ForEach(rootViewModel.businessSelected.tasks.filter({ $0.journeyId == viewModel.journey.id && $0.categoryId == category.id }).sorted(by: {$0.endDate < $1.endDate})) { task in
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
                                    
                                    if !(rootViewModel.businessSelected.tasks.filter({ $0.journeyId == viewModel.journey.id && $0.categoryId == nil})).isEmpty {
                                        HStack(spacing: 16) {
                                            Text("Sem categoria")
                                            Spacer()
                                        }
                                        .collieFont(textStyle: .subtitle)
                                        .foregroundColor(.white)
                                        .padding(.vertical, 12)
                                        .padding(.horizontal, 16)
                                        .background(Color.collieRoxoClaro)
                                        .cornerRadius(8)
                                        
                                        ForEach(rootViewModel.businessSelected.tasks.filter({ $0.journeyId == viewModel.journey.id && $0.categoryId == nil }).sorted(by: {$0.endDate < $1.endDate})) { task in
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
                            
                            HelpButton(handleTap: {
                                showEventsHint = true
                            })
                            .popover(isPresented: $showEventsHint, arrowEdge: .bottom) {
                                HelpView(title: "O que é um evento?", subtitle: "São encontros que você deseja que o colaborador, envolvem palestras ou conversas com o time. Eles tem dia e hora marcada para que um grupo se encontrem.")
                            }
                            
                            Spacer()
                            
                            DefaultButtonWithLeftIcon(
                                label: "Novo evento",
                                systemImageName: "calendar.badge.plus",
                                onTap: {
                                    showEventForm = true
                                }
                            )
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
            .padding(.horizontal, 32)
            .padding(.top, 32)
            .padding(.bottom)
            
            if editJourney {
                ZStack {
                    Color.black.opacity(0.5)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    CreateOrEditJourneyView(
                        userId: rootViewModel.currentUser.id,
                        journey: viewModel.journey,
                        handleClose: {
                            withAnimation {
                                editJourney = false
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
                        viewModel: CreateOrEditTaskViewModel(
                            currentBusiness: rootViewModel.businessSelected
                        ),
                        journeyId: viewModel.journey.id,
                        task: nil,
                        category: rootViewModel.getCategory(categoryId: ""),
                        handleClose: {
                            withAnimation {
                                showTaskForm = false
                            }
                        },
                        handleTaskDelete: { task in
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
                        viewModel: CreateOrEditEventViewModel(currentBusiness: rootViewModel.businessSelected),
                        event: nil,
                        category: rootViewModel.getCategory(categoryId: ""),
                        journeyId: viewModel.journey.id,
                        handleClose: {
                            withAnimation {
                                showEventForm = false
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
                        viewModel: CreateOrEditTaskViewModel(currentBusiness: rootViewModel.businessSelected),
                        journeyId: viewModel.journey.id,
                        task: chosenTask,
                        category: rootViewModel.getCategory(categoryId: chosenTask.categoryId ?? ""),
                        handleClose: {
                            withAnimation {
                                viewModel.unselectTask()
                            }
                        },
                        handleTaskDelete: { task in
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
                        viewModel: CreateOrEditEventViewModel(currentBusiness: rootViewModel.businessSelected),
                        event: chosenEvent,
                        category: rootViewModel.getCategory(categoryId: chosenEvent.categoryId ?? ""),
                        journeyId: viewModel.journey.id,
                        handleClose: {
                            withAnimation {
                                viewModel.unselectEvent()
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
