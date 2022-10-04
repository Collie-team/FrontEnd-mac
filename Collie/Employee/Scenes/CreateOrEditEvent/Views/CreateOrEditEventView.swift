import SwiftUI

struct CreateOrEditEventView: View {
    @ObservedObject var viewModel = CreateOrEditEventViewModel()
    
    var event: Event?
    var handleClose: () -> ()
    var handleEventSave: (Event) -> ()
    
    init(event: Event?, handleClose: @escaping () -> (), handleEventSave: @escaping (Event) -> ()) {
        self.event = event
        self.handleClose = handleClose
        self.handleEventSave = handleEventSave
        if let event = event {
            viewModel.eventName = event.name
            viewModel.startDate = event.startDate
            viewModel.endDate = event.endDate
            viewModel.eventDescription = event.description
            viewModel.eventLink = event.link
            
            if let responsibleEmployees = event.responsibleEmployees {
                viewModel.selectedUsers = responsibleEmployees
                viewModel.sampleUsers = viewModel.sampleUsers.filter({ user in
                    !viewModel.selectedUsers.contains(user)
                })
            }
            
            if let selectedCategory = event.category {
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
                    TitleTextField(text: $viewModel.eventName, showPlaceholderWhen: viewModel.eventName.isEmpty, placeholderText: "Nome do evento")
                    
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
                    
                    DatePicker("", selection: $viewModel.startDate, in: Date()..., displayedComponents: [.date, .hourAndMinute])
                        .datePickerStyle(.compact)
                        .padding(.horizontal)
                        .frame(width: 500, height: 40)
                        .background(Color.white)
                        .cornerRadius(8)
                }
                
                HStack {
                    TitleWithIconView(systemImageName: "calendar", label: "Data de término")
                    
                    Spacer()
                    
                    DatePicker("", selection: $viewModel.endDate, in: Date()..., displayedComponents: [.date, .hourAndMinute])
                        .datePickerStyle(.compact)
                        .padding(.horizontal)
                        .frame(width: 500, height: 40)
                        .background(Color.white)
                        .cornerRadius(8)
                }
                .padding(.bottom)
                
                VStack {
                    TitleWithIconView(systemImageName: "link", label: "Link do evento")
                    
                    SimpleTextField(text: $viewModel.eventLink, showPlaceholderWhen: viewModel.eventLink.isEmpty, placeholderText: "Adicione o link da plataforma que o evento vai acontecer")
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
                            viewModel.selectUser(user)
                        },
                        handleUserRemove: { user in
                            viewModel.removeUser(user)
                        }
                    )
                }
                
                VStack {
                    TitleWithIconView(systemImageName: "doc.text.fill", label: "Descrição do evento")
                    
                    MultiLineTextField(text: $viewModel.eventDescription, showPlaceholderWhen: viewModel.eventDescription.isEmpty, placeholderText: "Informações sobre o evento")
                }
                
                VStack {
                    TitleWithIconView(systemImageName: "tag.fill", label: "Categoria")
                    CategorySelectionDropdown(
                        showList: $viewModel.showCategoryList,
                        chosenCategory: $viewModel.selectedCategory,
                        taskCategoriesList: viewModel.sampleCategories,
                        maxScrollHeight: getAllCategoriesScrollHeight(),
                        handleCategorySelection: viewModel.selectCategory
                    )
                }

                SendButton(label: "Salvar tarefa", isButtonDisabled: viewModel.isButtonDisabled(), handleSend: {
                    handleEventSave(
                            Event(
                                name: viewModel.eventName,
                                description: viewModel.eventDescription,
                                link: viewModel.eventLink,
                                startDate: viewModel.startDate,
                                endDate: viewModel.endDate,
                                responsibleEmployees: viewModel.selectedUsers,
                                category: viewModel.selectedCategory
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

//struct CreateOrEditEventView_Previews: PreviewProvider {
//    static var previews: some View {
//        CreateOrEditEventView()
//    }
//}
