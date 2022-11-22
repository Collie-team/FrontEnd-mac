import SwiftUI

struct CreateOrEditEventView: View {
    @EnvironmentObject var rootViewModel: RootViewModel
    @ObservedObject var viewModel: CreateOrEditEventViewModel
    
    var event: Event?
    var category: TaskCategory
    var journeyId: String
    var handleClose: () -> ()
    var handleEventDelete: (Event) -> ()
    var handleEventDuplicate: (Event) -> ()
    
    init(
        viewModel: CreateOrEditEventViewModel,
        event: Event?,
        category: TaskCategory,
        journeyId: String,
        handleClose: @escaping () -> (),
        handleEventDelete: @escaping (Event) -> (),
        handleEventDuplicate: @escaping(Event) -> ()
    ) {
        self.viewModel = viewModel
        self.event = event
        self.category = category
        self.journeyId = journeyId
        self.handleClose = handleClose
        self.handleEventDelete = handleEventDelete
        self.handleEventDuplicate = handleEventDuplicate
        if let event = event {
            viewModel.eventId = event.id
            viewModel.eventName = event.name
            viewModel.startDate = event.startDate
            viewModel.endDate = event.endDate
            viewModel.eventDescription = event.description
            viewModel.eventLink = event.contentLink
            
            if !event.responsibleUserIds.isEmpty {
                viewModel.userModelList = viewModel.userModelList.filter({ user in
                    !viewModel.chosenUserModels.contains(user)
                })
            }
            
            viewModel.selectedCategory = category
            viewModel.categoryList = viewModel.categoryList.filter({ category in
                category.id != viewModel.selectedCategory!.id
            })
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
                    
                    if event != nil {
                        IconButton(imageSystemName: "rectangle.on.rectangle") {
                            if let event = event {
                                handleEventDuplicate(event)
                            }
                        }
                        
                        IconButton(imageSystemName: "trash") {
                            if let event = event {
                                handleEventDelete(event)
                            }
                        }
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
//                            viewModel.selectUser(user)
//                        },
//                        handleUserRemove: { user in
//                            viewModel.removeUser(user)
//                        }
//                    )
//                }
                
                VStack {
                    TitleWithIconView(systemImageName: "doc.text.fill", label: "Descrição do evento")
                    
                    MultiLineTextField(text: $viewModel.eventDescription, showPlaceholderWhen: viewModel.eventDescription.isEmpty, placeholderText: "Informações sobre o evento")
                }
                
                VStack {
                    TitleWithIconView(systemImageName: "tag.fill", label: "Categoria")
                    CategorySelectionDropdown(
                        showList: $viewModel.showCategoryList,
                        chosenCategory: $viewModel.selectedCategory,
                        taskCategoriesList: rootViewModel.businessSelected.categories.filter({ $0.id != viewModel.selectedCategory?.id}),
                        maxScrollHeight: getAllCategoriesScrollHeight(),
                        handleCategorySelection: viewModel.selectCategory
                    )
                }

                DefaultButton(
                    label: "salvar evento",
                    backgroundColor: .collieAzulEscuro,
                    isButtonDisabled: viewModel.isButtonDisabled(),
                    handleSend: {
                        viewModel.handleEventSave(journeyId: journeyId, completion: {
                            business in
                            rootViewModel.updateBusiness(business, replaceBusiness: true)
                        })
                        handleClose()
                    }
                )
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
        .onAppear {
            viewModel.fetchUsers(business: rootViewModel.businessSelected)
        }
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
    
    func getAllUsersScrollHeight() -> CGFloat {
        if viewModel.showUserList {
            if viewModel.userModelList.count >= 3 {
                return 160
            } else {
                return CGFloat((viewModel.userModelList.count + 1) * 40)
            }
        } else {
            return 40
        }
    }
    
    func getChosenUsersScrollHeight() -> CGFloat {
        if viewModel.chosenUserModels.count >= 3 {
            return 120
        } else {
            return CGFloat(viewModel.chosenUserModels.count * 40)
        }
    }
}

//struct CreateOrEditEventView_Previews: PreviewProvider {
//    static var previews: some View {
//        CreateOrEditEventView()
//    }
//}
