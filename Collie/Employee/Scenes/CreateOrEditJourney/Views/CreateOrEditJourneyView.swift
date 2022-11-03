import SwiftUI

struct CreateOrEditJourneyView: View {
    @ObservedObject var viewModel = CreateNewJourneyViewModel()
    @State var imageURL: String = ""//URL = URL(fileURLWithPath: "")
    
    var journey: Journey?
    var handleClose: () -> ()
    var handleJourneySave: (Journey) -> ()
    
    init(journey: Journey?, handleClose: @escaping () -> (), handleJourneySave: @escaping (Journey) -> ()) {
        self.handleClose = handleClose
        self.handleJourneySave = handleJourneySave
        if let journey = journey {
//            viewModel.tasks = journey.tasks
//            viewModel.events = journey.events
            viewModel.journeyId = journey.id
//            viewModel.chosenEmployees = journey.employees
//            viewModel.chosenManagers = journey.managers
            viewModel.journeyName = journey.name
            viewModel.journeyDescription = journey.description
            viewModel.startDate = journey.startDate
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
                    TitleTextField(text: $viewModel.journeyName, showPlaceholderWhen: viewModel.journeyName.isEmpty, placeholderText: "Nome da jornada")
                    
//                    FilePicker { imagePath in
//                        self.imageURL = URL(fileURLWithPath: imagePath)
//                    }
                }
                .padding(.bottom, 40)
                          
                VStack {
                    TitleWithIconView(systemImageName: "doc.text.fill", label: "Descrição da jornada")
                    MultiLineTextField(text: $viewModel.journeyDescription, showPlaceholderWhen: viewModel.journeyDescription.isEmpty, placeholderText: "Adicione uma descrição")
                }
                
                
                VStack {
                    TitleWithIconView(systemImageName: "calendar", label: "Data de início")
                    
                    DatePicker("", selection: $viewModel.startDate, in: Date()..., displayedComponents: [.date])
                        .datePickerStyle(.compact)
                        .padding(.horizontal)
                        .frame(height: 40)
                        .background(Color.white)
                        .cornerRadius(8)
                }
                
                VStack {
                    TitleWithIconView(systemImageName: "person.fill", label: "Gestor responsável")
                    
                    UserSelectionDropdown(
                        showList: $viewModel.showManagerList,
                        label: "Adicionar gestor",
                        allUsers: viewModel.sampleManagers,
                        selectedUsers: viewModel.chosenManagers,
                        allUsersScrollHeight: getAllManagersScrollHeight(),
                        selectedUsersScrollHeight: getChosenManagersScrollHeight(),
                        handleUserSelection: { user in
                            viewModel.selectManager(user)
                        },
                        handleUserRemove: { user in
                            viewModel.removeManager(user)
                        }
                    )
                }
                
                VStack {
                    TitleWithIconView(systemImageName: "person.2.fill", label: "Colaboradores na Jornada (opcional)")
                    
                    UserSelectionDropdown(
                        showList: $viewModel.showUsersList,
                        label: "Adicionar novo colaborador",
                        allUsers: viewModel.sampleUsers,
                        selectedUsers: viewModel.chosenEmployees,
                        allUsersScrollHeight: getAllUsersScrollHeight(),
                        selectedUsersScrollHeight: getChosenUsersScrollHeight(),
                        handleUserSelection: { user in
                            viewModel.selectUserModel(user)
                        },
                        handleUserRemove: { user in
                            viewModel.selectUserModel(user)
                        }
                    )
                }
                
                SendButton(label: "Salvar jornada", isButtonDisabled: viewModel.isButtonDisabled()) {
                    handleJourneySave(
                        Journey(
                            id: viewModel.journeyId ?? UUID().uuidString,
                            name: viewModel.journeyName,
                            description: viewModel.journeyDescription,
                            imageURL: imageURL,
                            startDate: viewModel.startDate
//                            employees: viewModel.chosenEmployees,
//                            tasks: viewModel.tasks,
//                            events: viewModel.events,
//                            managers: viewModel.chosenManagers
                        )
                    )
                    handleClose()
                }
            }
            .padding(.vertical)
            .padding(.horizontal, 32)
        }
        .background(
            VStack(spacing: 0) {
//                if let nsImage = NSImage(contentsOf: imageURL) {
//                    Image(nsImage: nsImage)
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                        .frame(maxWidth: .infinity)
//                        .frame(height: 130)
//                } else {
                Color.collieRoxoClaro
                    .frame(height: 130)
//                }
                Color.collieBrancoFundo
            }
        )
        .cornerRadius(8)
    }
    
    func getAllManagersScrollHeight() -> CGFloat {
        if viewModel.showManagerList {
            if viewModel.sampleManagers.count >= 3 {
                return 160
            } else {
                return CGFloat((viewModel.sampleManagers.count + 1) * 40)
            }
        } else {
            return 40
        }
    }
    
    func getChosenManagersScrollHeight() -> CGFloat {
        if viewModel.chosenManagers.count >= 3 {
            return 120
        } else {
            return CGFloat(viewModel.chosenManagers.count * 40)
        }
    }
    
    func getAllUsersScrollHeight() -> CGFloat {
        if viewModel.showUsersList {
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
        if viewModel.chosenEmployees.count >= 3 {
            return 120
        } else {
            return CGFloat(viewModel.chosenEmployees.count * 40)
        }
    }
}

struct CreateOrEditJourneyView_Previews: PreviewProvider {
    static var previews: some View {
        CreateOrEditJourneyView(journey: nil, handleClose: {}, handleJourneySave: {_ in })
    }
}
