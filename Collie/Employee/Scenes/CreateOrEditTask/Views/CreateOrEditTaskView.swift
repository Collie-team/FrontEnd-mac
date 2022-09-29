import SwiftUI

struct CreateOrEditTaskView: View {
    @ObservedObject var viewModel = CreateOrEditTaskViewModel()
    
    var handleClose: () -> ()
    var handleTaskCreation: (Task) -> ()
    
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
                    TextField("", text: $viewModel.taskName)
                        .placeholder(when: viewModel.taskName.isEmpty) {
                            Text("Nome da tarefa")
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
                        // TO DO
                    } label: {
                        Image(systemName: "rectangle.on.rectangle")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.black)
                            .frame(width: 40, height: 40)
                            .background(Color.white)
                            .cornerRadius(8)
                    }
                    .buttonStyle(.plain)
                    
                    Button {
                        // TO DO
                    } label: {
                        Image(systemName: "trash")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.black)
                            .frame(width: 40, height: 40)
                            .background(Color.white)
                            .cornerRadius(8)
                    }
                    .buttonStyle(.plain)

                }
                .padding(.bottom, 40)
                
                VStack {
                    HStack {
                        Image(systemName: "calendar")
                        Text("Data de início")
                        Spacer()
                        DatePicker("", selection: $viewModel.startDate, in: Date()..., displayedComponents: [.date])
                            .datePickerStyle(.compact)
                            .padding(.horizontal)
                            .frame(height: 40)
                            .background(Color.collieCinzaClaro)
                            .cornerRadius(8)
                    }
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.black)
                }
                
                VStack {
                    HStack {
                        Image(systemName: "calendar")
                        Text("Data de entrega")
                        Spacer()
                        DatePicker("", selection: $viewModel.endDate, in: Date()..., displayedComponents: [.date])
                            .datePickerStyle(.compact)
                            .padding(.horizontal)
                            .frame(height: 40)
                            .background(Color.collieCinzaClaro)
                            .cornerRadius(8)
                    }
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.black)
                }
                
                VStack {
                    HStack {
                        Group {
                            Image(systemName: "person.fill")
                            Text("Responsável")
                        }
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.black)
                        
                        Spacer()
                        VStack {
                            VStack {
                                ScrollView(.vertical) {
                                    VStack(spacing: 0) {
                                        Button {
                                            withAnimation {
                                                viewModel.showUserList.toggle()
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
                                        
                                        
                                        if viewModel.showUserList {
                                            ForEach(viewModel.sampleUsers) { user in
                                                UserCellView(user: user) {
                                                    
                                                }
                                            }
                                        }
                                    }
                                }
                                .frame(maxHeight: getAllUsersScrollHeight())
                                
                            }
                            .tint(.collieRosaEscuro)
                            .menuStyle(.borderlessButton)
                            .background(Color.collieCinzaClaro)
                            .foregroundColor(.black)
                            .cornerRadius(8)
                            
                            if viewModel.assignee != nil {
                                ScrollView(.vertical, showsIndicators: true) {
                                    VStack(spacing: 0) {
//                                        ForEach(viewModel.chosenManagers.reversed()) { manager in
//                                            ChosenUserCellView(user: manager) {
//
//                                            }
//                                        }
                                    }
                                }
                                .background(Color.white.opacity(0.5))
                                .cornerRadius(8)
                            }
                        }
                    }
                    
                    HStack {
                        Group {
                            Image(systemName: "doc.text.fill")
                            Text("Descrição da tarefa")
                        }
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.black)
                        
                        Spacer()
                        TextField("", text: $viewModel.taskDescription)
                            .placeholder(when: viewModel.taskDescription.isEmpty) {
                                Text("Informações sobre a atividade proposta")
                                    .foregroundColor(.gray)
                            }
                            .padding(.horizontal)
                            .tint(.collieRosaEscuro)
                            .textFieldStyle(.plain)
                            .frame(height: 40)
                            .background(Color.collieCinzaClaro)
                            .foregroundColor(.black)
                            .cornerRadius(8)
                            .lineLimit(3)
                    }
                }
                
                HStack {
                    Group {
                        Image(systemName: "tag.fill")
                        Text("Categoria")
                    }
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.black)
                    
                    Spacer()
                
                }
                
                Button {
                    handleTaskCreation(
                        Task(
                            name: viewModel.taskName,
                            description: viewModel.taskDescription,
                            taskCategory: TaskCategory(name: "", description: "", colorName: "")
                        )
                    )
                    handleClose()
                } label: {
                    Text("Salvar jornada")
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
                Color.white
            }
        )
        .cornerRadius(8)
    }
    
    func getAllUsersScrollHeight() -> CGFloat {
        if viewModel.showUserList {
            if viewModel.sampleUsers.count >= 3 {
                return 184
            } else {
                return CGFloat((viewModel.sampleUsers.count + 1) * 46)
            }
        } else {
            return 46
        }
    }
}

struct CreateOrEditTaskView_Previews: PreviewProvider {
    static var previews: some View {
        CreateOrEditTaskView(handleClose: {}, handleTaskCreation: {_ in})
    }
}
