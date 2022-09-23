import SwiftUI

struct TeamListView: View {
    @ObservedObject var viewModel = TeamListViewModel()
    
    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: true) {
                VStack {
                    HStack(alignment: .bottom) {
                        VStack(alignment: .leading) {
                            Text("Acompanhamento")
                                .font(.system(size: 34, weight: .bold, design: .default))
                                .foregroundColor(Color.black)
                                .padding(.bottom, 12)
                            Text("Faça um acompanhamento geral do seu time :P")
                                .font(.system(size: 16, weight: .semibold, design: .rounded))
                                .foregroundColor(Color.black.opacity(0.6))
                        }
                        Spacer()
                        VStack(alignment: .trailing) {
                            HStack {
                                Image(systemName: "bell")
                                    .foregroundColor(Color.collieRoxo)
                                    .font(.system(size: 16, weight: .semibold))
                                    .padding()
                                    .overlay(
                                        ZStack {
                                            Circle()
                                                .frame(width: 14, height: 14)
                                                .foregroundColor(.red)
                                            Text("4")
                                                .font(.system(size: 10))
                                        }
                                        .offset(x: 7, y: -7)
                                    )
                                ZStack {
                                    Circle()
                                        .foregroundColor(.gray)
                                        .frame(width: 36, height: 36)
                                    Text("A")
                                        .font(.system(size: 14))
                                }
                            }
                            HStack {
                                Button(action: {
                                    viewModel.newUserPopupEnabled = true
                                }) {
                                    HStack {
                                        Image(systemName: "plus.circle.fill")
                                        Text("Adicionar Usuários")
                                    }
                                    .foregroundColor(.white)
                                    .padding(8)
                                    .padding(.horizontal,8)
                                }
                                .buttonStyle(.plain)
                                .background(Color.collieRoxo)
                                .cornerRadius(8)
                                Button(action: {}) {
                                    HStack {
                                        Text("Filtros")
                                            .padding(.trailing,8)
                                        Image(systemName: "chevron.down")
                                    }
                                    .foregroundColor(.gray)
                                    .padding(8)
                                }
                                .buttonStyle(.plain)
                                .background(Color.white)
                                .cornerRadius(8)
                            }
                        }
                    }
                    .padding(.bottom)

                    ForEach(viewModel.sampleUsers) { user in
                        HStack(spacing: 0) {
                            ZStack {
                                Circle()
                                    .frame(width: 48, height: 48)
                                    .foregroundColor(.collieRosaClaro)
                                Text("AA")
                                    .font(.system(size: 16, weight: .bold, design: .default))
                            }
                            .padding(.trailing)
                            
                            Text("\(user.name)")
                                .foregroundColor(.black)
                            Spacer()
                            
                            Text("3/14")
                                .font(.system(size: 17))
                                .foregroundColor(.black)
                                .padding(.horizontal)
                            
                            Button(action: {}) {
                                Image(systemName: "xmark")
                                    .font(.system(size: 13))
                                    .foregroundColor(.gray)
                            }
                            .buttonStyle(.plain)
                        }
                        .padding()
                        .frame(height: 60)
                        .background(Color.white)
                        .cornerRadius(8)
                    }
                    
                    Spacer()
                }
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 32)
        .frame(maxWidth: .infinity)
        .frame(maxHeight: .infinity)
        .background(Color.collieBranco.ignoresSafeArea())
        .navigationTitle("Acompanhamento do time")
        .onAppear() {
            viewModel.fetchUsers()
        }
        .popover(isPresented: $viewModel.newUserPopupEnabled) {
            NewUserFormsView()
                .environmentObject(viewModel)
        }
    }
}

struct TeamListView_Previews: PreviewProvider {
    static var previews: some View {
        TeamListView()
    }
}

struct NewUserFormsView: View {
    @EnvironmentObject var viewModel: TeamListViewModel
    @State var newUser = User(name: "", email: "", jobDescription: "", personalDescription: "", imageURL: "", businessId: "")
    var body: some View {
        VStack {
            Text("Adicionar novo usuário:")
                .font(.headline)
            TextField("Nome", text: $newUser.name)
            TextField("E-mail", text: $newUser.email)
            TextField("Descrição da função", text: $newUser.jobDescription)
            Button(action: {
                viewModel.registerUser(userToAdd: newUser)
            }) {
                Text("Cadastrar novo usuário")
            }
            Button(action: {
                viewModel.newUserPopupEnabled = false
            }) {
                Text("Cancelar")
            }
        }
        .padding(50)
        .cornerRadius(25)
    }
}
