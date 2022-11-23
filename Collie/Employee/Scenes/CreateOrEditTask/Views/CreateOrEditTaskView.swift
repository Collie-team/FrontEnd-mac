import SwiftUI

struct CreateOrEditTaskView: View {
    @EnvironmentObject var rootViewModel: RootViewModel
    @ObservedObject var viewModel: CreateOrEditTaskViewModel
    
    var task: Task?
    var category: TaskCategory
    var journeyId: String
    var handleClose: () -> ()
    var handleTaskDelete: (Task) -> ()
    var handleTaskDuplicate: (Task) -> ()
    
    init(
        viewModel: CreateOrEditTaskViewModel,
        journeyId: String,
        task: Task?,
        category: TaskCategory,
        handleClose: @escaping () -> (),
        handleTaskDelete: @escaping (Task) -> (),
        handleTaskDuplicate: @escaping (Task) -> ()
    ) {
        self.viewModel = viewModel
        self.journeyId = journeyId
        self.task = task
        self.category = category
        self.handleClose = handleClose
        self.handleTaskDelete = handleTaskDelete
        self.handleTaskDuplicate = handleTaskDuplicate
        if let task = task {
            viewModel.taskId = task.id
            viewModel.taskName = task.name
            viewModel.taskDescription = task.description
            viewModel.startDate = task.startDate
            viewModel.endDate = task.endDate
            viewModel.selectedCategory = category
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                CloseButton(handleClose: handleClose)
            }
            .padding(.top, 8)
            .padding(.trailing, 8)
            
            VStack(spacing: 16) {
                HStack {
                    TitleTextField(text: $viewModel.taskName, showPlaceholderWhen: viewModel.taskName.isEmpty, placeholderText: "Nome da tarefa")
                    
                    if task != nil {
                        IconButton(imageSystemName: "trash") {
                            if let task = task {
                                handleTaskDelete(task)
                            }
                        }
                    }
                }
                .padding(.bottom, 40)
                
                HStack {
                    TitleWithIconView(systemImageName: "calendar", label: "Data de início")
                    
                    Spacer()
                    
                    DatePicker("", selection: $viewModel.startDate, in: Date()..., displayedComponents: [.date])
                        .datePickerStyle(.compact)
                        .padding(.horizontal)
                        .frame(width: 500, height: 40)
                        .background(Color.white)
                        .cornerRadius(8)
                }
                
                HStack {
                    TitleWithIconView(systemImageName: "calendar", label: "Data de entrega")
                    Spacer()
                    DatePicker("", selection: $viewModel.endDate, in: Date()..., displayedComponents: [.date])
                        .datePickerStyle(.compact)
                        .padding(.horizontal)
                        .frame(width: 500, height: 40)
                        .background(Color.white)
                        .cornerRadius(8)
                }
                
//                VStack {
//                    TitleWithIconView(systemImageName: "person.fill", label: "Responsável")
//
//                    UserSelectionDropdown(
//                        showList: $viewModel.showUserList,
//                        label: "Escolha um responsável",
//                        allUsers: viewModel.userModelList,
//                        selectedUsers: viewModel.chosenUserModels,
//                        allUsersScrollHeight: getAllUsersScrollHeight(),
//                        selectedUsersScrollHeight: getChosenUsersScrollHeight(),
//                        handleUserSelection: { user in
//                            viewModel.chooseUser(user)
//                        },
//                        handleUserRemove: { user in
//                            viewModel.removeUser(user)
//                        }
//                    )
//                }
                
                VStack {
                    TitleWithIconView(systemImageName: "doc.text.fill", label: "Descrição da tarefa")
                    
                    MultiLineTextField(text: $viewModel.taskDescription, showPlaceholderWhen: viewModel.taskDescription.isEmpty, placeholderText: "Informações sobre a atividade proposta")
                }
                
                VStack {
                    TitleWithIconView(systemImageName: "tag.fill", label: "Categoria")
                    CategorySelectionDropdown(
                        showList: $viewModel.showCategoryList,
                        chosenCategory: $viewModel.selectedCategory,
                        taskCategoriesList: rootViewModel.businessSelected.categories.filter({ $0.id != viewModel.selectedCategory?.id}),
                        maxScrollHeight: getAllCategoriesScrollHeight(),
                        handleCategorySelection: viewModel.chooseCategory
                    )
                }

                DefaultButton(
                    label: "salvar tarefa",
                    backgroundColor: .collieAzulEscuro,
                    isButtonDisabled: viewModel.isButtonDisabled(),
                    handleSend: {
                        viewModel.handleTaskSave(journeyId: journeyId, completion: { business in
                            rootViewModel.updateBusiness(business, replaceBusiness: true)
                        })
                        handleClose()
                    }
                )
                .frame(maxWidth: 300)
            }
            .padding(.vertical)
            .padding(.horizontal, 32)
        }
        .background(
            VStack(spacing: 0) {
                Group {
                    if viewModel.selectedCategory != nil {
                        viewModel.selectedCategory!.color
                    } else {
                        Color.collieRoxoClaro
                    }
                }
                .frame(height: 130)
                Color.collieBrancoFundo
            }
        )
        .cornerRadius(8)
    }
    
    func getAllCategoriesScrollHeight() -> CGFloat {
        if viewModel.showCategoryList {
            if viewModel.categoryList.count >= 3 {
                return 160
            } else {
                return CGFloat((viewModel.categoryList.count + 1) * 40)
            }
        } else {
            return 40
        }
    }
}
