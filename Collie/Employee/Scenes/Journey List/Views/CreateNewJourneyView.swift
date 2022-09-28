import SwiftUI

struct CreateNewJourneyView: View {
    @ObservedObject var viewModel = CreateNewJourneyViewModel()
    @State var imageURL: URL = URL(fileURLWithPath: "")
    
    var handleClose: () -> ()
    var handleJourneyCreation: (Journey) -> ()
        
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    handleClose()
                } label: {
                    Image(systemName: "xmark.circle")
                        .font(.system(size: 21, weight: .bold, design: .default))
                        .foregroundColor(.white)
                }
                .buttonStyle(.plain)
            }
            .padding(.top, 8)
            .padding(.trailing, 8)
            
            VStack(spacing: 16) {
                HStack {
                    TextField("", text: $viewModel.journeyName)
                        .placeholder(when: viewModel.journeyName.isEmpty) {
                            Text("Nome da jornada")
                                .font(.system(size: 21))
                                .bold()
                                .foregroundColor(.gray)
                        }
                        .font(.system(size: 21, weight: .bold))
                        .padding(.horizontal)
                        .tint(.collieRosaEscuro)
                        .textFieldStyle(.plain)
                        .frame(height: 40)
                        .background(Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(8)
                    
                    FilePicker { imagePath in
                        self.imageURL = URL(fileURLWithPath: imagePath)
                    }
                }
                                
                TextField("", text: $viewModel.journeyDescription)
                    .placeholder(when: viewModel.journeyDescription.isEmpty) {
                        Text("Descrição da jornada")
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal)
                    .tint(.collieRosaEscuro)
                    .textFieldStyle(.plain)
                    .frame(height: 40)
                    .background(Color.white)
                    .foregroundColor(.black)
                    .cornerRadius(8)
                    .lineLimit(3)
                
                VStack {
                    HStack {
                        Image(systemName: "calendar")
                        Text("Data de início")
                        Spacer()
                    }
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.black)
                    
                    DatePicker("", selection: $viewModel.startDate, in: Date()..., displayedComponents: [.date])
                        .datePickerStyle(.compact)
                        .padding(.horizontal)
                        .frame(height: 40)
                        .background(Color.white)
                        .cornerRadius(8)
                }
                
                VStack {
                    HStack {
                        Image(systemName: "person.fill")
                        Text("Gestor responsável")
                        Spacer()
                    }
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.black)
                    
                    VStack {
                        ScrollView(.vertical) {
                            VStack(spacing: 0) {
                                Button {
                                    withAnimation {
                                        viewModel.showManagerList.toggle()
                                    }
                                } label: {
                                    VStack(spacing: 0) {
                                        HStack {
                                            Text("Adicionar gestor")
                                                .padding(.vertical)
                                            Spacer()
                                            Image(systemName: "chevron.down")
                                        }
                                        Divider()
                                    }
                                    .frame(height: 46)
                                    .frame(maxWidth: .infinity)
                                    .padding(.horizontal)
                                    .contentShape(Rectangle())
                                }
                                .buttonStyle(.plain)
                                
                                
                                if viewModel.showManagerList {
                                    ForEach(viewModel.sampleManagers) { user in
                                        UserCellView(user: user) {
                                            viewModel.selectManager(user)
                                        }
                                    }
                                }
                            }
                        }
                        .frame(maxHeight: getAllManagersScrollHeight())
                    }
                    .tint(.collieRosaEscuro)
                    .menuStyle(.borderlessButton)
                    .background(Color.white)
                    .foregroundColor(.black)
                    .cornerRadius(8)
                    
                    if !viewModel.chosenManagers.isEmpty {
                        ScrollView(.vertical, showsIndicators: true) {
                            VStack(spacing: 0) {
                                ForEach(viewModel.chosenManagers.reversed()) { manager in
                                    ChosenUserCellView(user: manager) {
                                        viewModel.removeManager(manager)
                                    }
                                }
                            }
                        }
                        .frame(maxHeight: getChosenManagersScrollHeight())
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(8)
                    }
                }
                
                VStack {
                    HStack {
                        Image(systemName: "person.2.fill")
                        Text("Colaboradores na Jornada (opcional)")
                        Spacer()
                    }
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.black)
                    
                    VStack {
                        ScrollView(.vertical) {
                            VStack(spacing: 0) {
                                Button {
                                    withAnimation {
                                        viewModel.showUsersList.toggle()
                                    }
                                } label: {
                                    VStack(spacing: 0) {
                                        HStack {
                                            Text("Adicionar novo colaborador")
                                                .padding(.vertical)
                                            Spacer()
                                            Image(systemName: "chevron.down")
                                        }
                                        Divider()
                                    }
                                    .frame(height: 46)
                                    .frame(maxWidth: .infinity)
                                    .padding(.horizontal)
                                    .contentShape(Rectangle())
                                }
                                .buttonStyle(.plain)
                                
                                
                                if viewModel.showUsersList {
                                    ForEach(viewModel.sampleUsers) { user in
                                        UserCellView(user: user) {
                                            viewModel.selectUser(user)
                                        }
                                    }
                                }
                            }
                        }
                        .frame(maxHeight: getAllUsersScrollHeight())
                    }
                    .tint(.collieRosaEscuro)
                    .menuStyle(.borderlessButton)
                    .background(Color.white)
                    .foregroundColor(.black)
                    .cornerRadius(8)
                    
                    if !viewModel.chosenUsers.isEmpty {
                        ScrollView(.vertical, showsIndicators: true) {
                            VStack(spacing: 0) {
                                ForEach(viewModel.chosenUsers.reversed()) { user in
                                    ChosenUserCellView(user: user) {
                                        viewModel.removeUser(user)
                                    }
                                }
                            }
                        }
                        .frame(maxHeight: getChosenUsersScrollHeight())
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(8)
                    }
                }
                
                Button {
                    handleJourneyCreation(
                        Journey(name: viewModel.journeyName, durationInDays: 7, description: viewModel.journeyDescription, imageURL: imageURL, usersIds: viewModel.chosenUsers.map{ $0.id }, tasks: [], managers: viewModel.chosenManagers)
                    )
                    handleClose()
                } label: {
                    Text("Criar jornada")
                        .font(.system(size: 18, weight: .bold))
                        .padding(.vertical, 8)
                        .padding(.horizontal, 32)
                        .background(viewModel.isButtonDisabled() ? Color.gray : Color.collieRoxo)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .buttonStyle(.plain)
                .disabled(viewModel.isButtonDisabled())
                .padding(.top)
            }
            .padding(.vertical)
            .padding(.horizontal, 32)
        }
        .background(
            VStack(spacing: 0) {
                if let nsImage = NSImage(contentsOf: imageURL) {
                    Image(nsImage: nsImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity)
                        .frame(height: 130)
                } else {
                    Color.collieVermelho
                        .frame(height: 130)
                }
                Color.collieCinzaClaro
            }
        )
        .cornerRadius(8)
    }
    
    func getAllManagersScrollHeight() -> CGFloat {
        if viewModel.showManagerList {
            if viewModel.sampleManagers.count >= 3 {
                return 184
            } else {
                return CGFloat((viewModel.sampleManagers.count + 1) * 46)
            }
        } else {
            return 46
        }
    }
    
    func getChosenManagersScrollHeight() -> CGFloat {
        if viewModel.chosenManagers.count >= 3 {
            return 138
        } else {
            return CGFloat(viewModel.chosenManagers.count * 46)
        }
    }
    
    func getAllUsersScrollHeight() -> CGFloat {
        if viewModel.showUsersList {
            if viewModel.sampleUsers.count >= 3 {
                return 184
            } else {
                return CGFloat((viewModel.sampleUsers.count + 1) * 46)
            }
        } else {
            return 46
        }
    }
    
    func getChosenUsersScrollHeight() -> CGFloat {
        if viewModel.chosenUsers.count >= 3 {
            return 138
        } else {
            return CGFloat(viewModel.chosenUsers.count * 46)
        }
    }
}

struct CreateNewJourneyView_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewJourneyView(handleClose: {}, handleJourneyCreation: {_ in })
    }
}
