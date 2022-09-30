import SwiftUI

struct CreateOrEditTaskView: View {
    @ObservedObject var viewModel = CreateOrEditTaskViewModel()
    
    var handleClose: () -> ()
    var handleTaskCreation: (Task) -> ()
    
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
                
                TitleWithIconView(systemImageName: "tag.fill", label: "Categoria")

                SendButton(label: "Salvar jornada", isButtonDisabled: viewModel.isButtonDisabled(), handleSend: {
                        handleTaskCreation(
                            Task(
                                name: viewModel.taskName,
                                description: viewModel.taskDescription,
                                taskCategory: TaskCategory(name: "", description: "", colorName: "")
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
                Color.collieVermelho
                    .frame(height: 130)
                Color.collieBranco
            }
        )
        .cornerRadius(8)
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
        CreateOrEditTaskView(handleClose: {}, handleTaskCreation: {_ in})
    }
}
