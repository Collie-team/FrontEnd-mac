import SwiftUI

struct CreateOrEditTaskView: View {
    @ObservedObject var viewModel = CreateOrEditTaskViewModel()
    
    var task: Task?
    var handleClose: () -> ()
    var handleTaskCreation: (Task) -> ()
    
    init(task: Task?, handleClose: @escaping () -> (), handleTaskCreation: @escaping (Task) -> ()) {
        self.task = task
        self.handleClose = handleClose
        self.handleTaskCreation = handleTaskCreation
        if let task = task {
            viewModel.taskName = task.name
            viewModel.taskDescription = task.description
            viewModel.startDate = task.startDate
            viewModel.endDate = task.endDate
            if let responsibleEmployees = task.responsibleEmployees {
                viewModel.selectedUsers = responsibleEmployees
                viewModel.sampleUsers = viewModel.sampleUsers.filter({ user in
                    !viewModel.selectedUsers.contains(user)
                })
            }
            if let selectedCategory = task.taskCategory {
                viewModel.selectedCategory = selectedCategory
                viewModel.sampleCategories = viewModel.sampleCategories.filter({ category in
                    category.id != selectedCategory.id
                })
            }
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
                    
                    IconButton(imageSystemName: "rectangle.on.rectangle") {
                        // TO DO
                    }
                    
                    IconButton(imageSystemName: "trash") {
                        // TO DO
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
                
                VStack {
                    TitleWithIconView(systemImageName: "person.fill", label: "Responsável")
                    
                    UserSelectionDropdown(
                        showList: $viewModel.showUserList,
                        label: "Escolha um responsável",
                        allUsers: viewModel.sampleUsers,
                        selectedUsers: viewModel.selectedUsers,
                        allUsersScrollHeight: getAllUsersScrollHeight(),
                        selectedUsersScrollHeight: getChosenUsersScrollHeight(),
                        handleUserSelection: { user in
                            viewModel.chooseUser(user)
                        },
                        handleUserRemove: { user in
                            viewModel.removeUser(user)
                        }
                    )
                }
                
                VStack {
                    TitleWithIconView(systemImageName: "doc.text.fill", label: "Descrição da tarefa")
                    
                    MultiLineTextField(text: $viewModel.taskDescription, showPlaceholderWhen: viewModel.taskDescription.isEmpty, placeholderText: "Informações sobre a atividade proposta")
                }
                
                VStack {
                    TitleWithIconView(systemImageName: "tag.fill", label: "Categoria")
                    CategorySelectionDropdown(
                        showList: $viewModel.showCategoryList,
                        chosenCategory: $viewModel.selectedCategory,
                        taskCategoriesList: viewModel.sampleCategories,
                        maxScrollHeight: getAllCategoriesScrollHeight(),
                        handleCategorySelection: viewModel.chooseCategory
                    )
                }

                SendButton(label: "Salvar tarefa", isButtonDisabled: viewModel.isButtonDisabled(), handleSend: {
                        handleTaskCreation(
                            Task(
                                name: viewModel.taskName,
                                responsibleEmployees: viewModel.selectedUsers,
                                description: viewModel.taskDescription,
                                startDate: viewModel.startDate,
                                endDate: viewModel.endDate,
                                taskCategory: viewModel.selectedCategory
                            )
                        )
                        handleClose()
                })
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
                        Color.collieRosaClaro
                    }
                }
                .frame(height: 130)
                Color.collieBranco
            }
        )
        .cornerRadius(8)
    }
    
    func getAllCategoriesScrollHeight() -> CGFloat {
        if viewModel.showCategoryList {
            if viewModel.sampleCategories.count >= 3 {
                return 160
            } else {
                return CGFloat((viewModel.sampleCategories.count + 1) * 40)
            }
        } else {
            return 40
        }
    }
    
    func getAllUsersScrollHeight() -> CGFloat {
        if viewModel.showUserList {
            if viewModel.sampleUsers.count >= 3 {
                return 160
            } else {
                return CGFloat((viewModel.sampleUsers.count + 1) * 40)
            }
        } else {
            return 40
        }
    }
    
    func getChosenUsersScrollHeight() -> CGFloat {
        if viewModel.selectedUsers.count >= 3 {
            return 120
        } else {
            return CGFloat(viewModel.selectedUsers.count * 40)
        }
    }
}

struct CreateOrEditTaskView_Previews: PreviewProvider {
    static var previews: some View {
        CreateOrEditTaskView(task: nil, handleClose: {}, handleTaskCreation: {_ in})
    }
}
