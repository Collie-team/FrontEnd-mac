import SwiftUI

struct CreateOrEditJourneyView: View {
    @EnvironmentObject var rootViewModel: RootViewModel
    @ObservedObject var viewModel = CreateNewJourneyViewModel()
    @State var imageURL: String = ""
    
    var handleClose: () -> ()
    var handleJourneySave: (Journey) -> ()
    
    init(journey: Journey?, handleClose: @escaping () -> (), handleJourneySave: @escaping (Journey) -> ()) {
        self.handleClose = handleClose
        self.handleJourneySave = handleJourneySave
        if let journey = journey {
            viewModel.journeyId = journey.id
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
                    TitleWithIconView(systemImageName: "person.2.fill", label: "Colaboradores na Jornada (opcional)")
                    
                    UserSelectionDropdown(
                        showList: $viewModel.showUsersList,
                        label: "Adicionar novo colaborador",
                        allUsers: viewModel.userModelList,
                        selectedUsers: viewModel.chosenUserModels,
                        allUsersScrollHeight: getAllUsersScrollHeight(),
                        selectedUsersScrollHeight: getChosenUsersScrollHeight(),
                        handleUserSelection: { userModel in
                            viewModel.selectUserModel(userModel)
                        },
                        handleUserRemove: { userModel in
                            viewModel.selectUserModel(userModel)
                        }
                    )
                }
                
                SendButton(label: "Salvar jornada", isButtonDisabled: viewModel.isButtonDisabled()) {
                    viewModel.handleJourneySave { journey in
                        handleJourneySave(journey)
                    }
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
        .onAppear {
            viewModel.fetchUsers(business: rootViewModel.businessSelected)
        }
    }
    
    func getAllUsersScrollHeight() -> CGFloat {
        if viewModel.showUsersList {
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

struct CreateOrEditJourneyView_Previews: PreviewProvider {
    static var previews: some View {
        CreateOrEditJourneyView(journey: nil, handleClose: {}, handleJourneySave: {_ in })
    }
}
