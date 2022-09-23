import SwiftUI

struct CreateNewJourneyView: View {
    @ObservedObject var viewModel = CreateNewJourneyViewModel()
    
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
                    
                    Button {
                        print("Add image")
                    } label: {
                        Image(systemName: "photo")
                            .font(.system(size: 24))
                    }
                    .buttonStyle(.plain)
                    .foregroundColor(.white)
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
                    
                    Menu {
                        ForEach(viewModel.sampleManagers) { user in
                            Button {
                                viewModel.selectManager(user)
                            } label: {
                                HStack(spacing: 8) {
                                    Circle()
                                        .foregroundColor(.collieRosaEscuro)
                                        .frame(width: 20, height: 20)
                                    Text("\(user.name)")
                                }
                            }
                        }
                    } label: {
                        Text("Adicionar gestor")
                    }
                    .padding(.horizontal)
                    .tint(.collieRosaEscuro)
                    .menuStyle(.borderlessButton)
                    .frame(height: 40)
                    .background(Color.white)
                    .foregroundColor(.black)
                    .cornerRadius(8)
                    
                    if !viewModel.chosenManagers.isEmpty {
                        ScrollView(.vertical, showsIndicators: true) {
                            VStack(spacing: 0) {
                                ForEach(viewModel.chosenManagers.reversed()) { manager in
                                    VStack(spacing: 0) {
                                        HStack {
                                            Circle()
                                                .foregroundColor(.collieRoxo)
                                                .frame(width: 30, height: 30)
                                            
                                            Text(manager.name)
                                            
                                            Spacer()
                                            
                                            Text(manager.jobDescription)
                                            
                                            Button {
                                                viewModel.removeManager(manager)
                                            } label: {
                                                Image(systemName: "xmark")
                                                    .font(.system(size: 16, weight: .bold))
                                                    .foregroundColor(.collieRoxo)
                                            }
                                            .buttonStyle(.plain)

                                        }
                                        .padding(.horizontal)
                                        .padding(.vertical, 8)
                                        
                                        Divider()
                                            .frame(height: 1)
                                    }
                                }
                            }
                        }
                        .frame(height: getScrollHeight(unitsChosen: viewModel.chosenManagers.count))
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
                    
                    Menu {
                        ForEach(viewModel.sampleUsers) { user in
                            Button {
                                viewModel.selectUser(user)
                            } label: {
                                HStack(spacing: 8) {
                                    Circle()
                                        .foregroundColor(.collieRosaEscuro)
                                        .frame(width: 20, height: 20)
                                    Text("\(user.name)")
                                }
                            }
                        }
                    } label: {
                        Text("Adicionar novo colaborador")
                    }
                    .padding(.horizontal)
                    .tint(.collieRosaEscuro)
                    .menuStyle(.borderlessButton)
                    .frame(height: 40)
                    .background(Color.white)
                    .foregroundColor(.black)
                    .cornerRadius(8)
                    
                    if !viewModel.chosenUsers.isEmpty {
                        ScrollView(.vertical, showsIndicators: true) {
                            VStack(spacing: 0) {
                                ForEach(viewModel.chosenUsers.reversed()) { user in
                                    VStack(spacing: 0) {
                                        HStack {
                                            Circle()
                                                .foregroundColor(.collieRoxo)
                                                .frame(width: 30, height: 30)
                                            
                                            Text(user.name)
                                            
                                            Spacer()
                                            
                                            Text(user.jobDescription)
                                            
                                            Button {
                                                viewModel.removeUser(user)
                                            } label: {
                                                Image(systemName: "xmark")
                                                    .font(.system(size: 16, weight: .bold))
                                                    .foregroundColor(.collieRoxo)
                                            }
                                            .buttonStyle(.plain)

                                        }
                                        .padding(.horizontal)
                                        .padding(.vertical, 8)
                                        
                                        Divider()
                                    }
                                }
                            }
                        }
                        .frame(height: getScrollHeight(unitsChosen: viewModel.chosenUsers.count))
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(8)
                    }
                }
                
                Button {
                    handleJourneyCreation(
                        Journey(name: viewModel.journeyName, durationInDays: 7, description: viewModel.journeyDescription, imageURL: "", usersIds: [], tasks: [], managers: viewModel.chosenManagers)
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
                Color.collieVermelho
                    .frame(height: 130)
                Color.collieCinzaClaro
            }
        )
        .cornerRadius(8)
    }
    
    func getScrollHeight(unitsChosen: Int) -> CGFloat {
        var height: CGFloat = 0
        if unitsChosen < 3 {
            height = CGFloat(unitsChosen * 46)
        } else {
            height = 138
        }
        return height
    }
}

struct CreateNewJourneyView_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewJourneyView(handleClose: {}, handleJourneyCreation: {_ in })
    }
}
