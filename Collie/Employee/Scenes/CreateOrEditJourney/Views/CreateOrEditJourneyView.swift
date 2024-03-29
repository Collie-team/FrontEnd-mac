import SwiftUI

struct CreateOrEditJourneyView: View {
    @EnvironmentObject var rootViewModel: RootViewModel
    @ObservedObject var viewModel: CreateNewJourneyViewModel
    @State var imageURL: String = ""
    @State var timeoutSaveWhenUploadsImage = false {
        didSet {
            if timeoutSaveWhenUploadsImage {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    timeoutSaveWhenUploadsImage = false
                }
            }
        }
    }
    
    var handleJourneySave: (Journey) -> ()
    var handleClose: () -> ()
    
    init(userId: String, currentBusiness: Business, journey: Journey?, handleJourneySave: @escaping (Journey) -> (), handleClose: @escaping () -> ()) {
        self.handleJourneySave = handleJourneySave
        self.viewModel = CreateNewJourneyViewModel(userId: userId, currentBusiness: currentBusiness)
        self.handleClose = handleClose
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
//                    IconButton(imageSystemName: "photo", action: {
//                        // TODO: Openfile selection
//                        rootViewModel.openFileSelectionForJourneyImage(journeyId: viewModel.journeyId) { didUpdateImage in
//                            self.timeoutSaveWhenUploadsImage = didUpdateImage
//                        }
//                    })
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
                            viewModel.removeUserModel(userModel)
                        }
                    )
                }
                
                DefaultButton(
                    label: "salvar jornada",
                    backgroundColor: .collieAzulEscuro,
                    isButtonDisabled: viewModel.isButtonDisabled()
                ) {
                    viewModel.handleJourneySave { business, journey in
                        rootViewModel.updateBusiness(business, replaceBusiness: true)
                        handleJourneySave(journey)
                    }
                    handleClose()
                }
                .frame(maxWidth: 300)
                .disabled(timeoutSaveWhenUploadsImage)
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

//struct CreateOrEditJourneyView_Previews: PreviewProvider {
//    static var previews: some View {
//        CreateOrEditJourneyView(userId: "", currentBusiness: , journey: nil, handleJourneySave: {_ in }, handleClose: {})
//    }
//}
