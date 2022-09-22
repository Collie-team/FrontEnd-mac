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
                        .foregroundColor(.collieRoxo)
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
                        Image(systemName: "person.fill")
                        Text("Gestor responsável")
                        Spacer()
                    }
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.black)
                    
                    Menu {
                        ForEach((1...5), id: \.self) { _ in
                            Text("Nome do gestor")
                        }
                    } label: {
                        Text("Adicionar gestor")
                    }
                    .menuStyle(.borderlessButton)
                    .padding(.horizontal)
                    .frame(height: 40)
                    .background(Color.white)
                    .cornerRadius(8)
                    
                }
                
                VStack {
                    HStack {
                        Image(systemName: "person.2.fill")
                        Text("Novos colaboradores")
                        Spacer()
                    }
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.black)
                    
                    
                }
                
                Button {
                    handleJourneyCreation(
                        Journey(name: viewModel.journeyName, durationInDays: 7, description: viewModel.journeyDescription, imageURL: "", usersIds: [], tasks: [])
                    )
                    handleClose()
                } label: {
                    Text("Criar jornada")
                        .bold()
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
                Color.collieRosaClaro
                Color.collieCinzaClaro
                Color.collieCinzaClaro
            }
        )
        .cornerRadius(8)
    }
}

struct CreateNewJourneyView_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewJourneyView(handleClose: {}, handleJourneyCreation: {_ in })
    }
}
