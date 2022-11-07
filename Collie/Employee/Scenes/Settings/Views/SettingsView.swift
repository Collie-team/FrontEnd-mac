import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel = SettingsViewModel()
    @State var showDeleteAlert = false
    
    var body: some View {
        VStack {
            HStack {
                Text("Configurações")
                    .font(.system(size: 40, weight: .bold, design: .default))
                    .foregroundColor(Color.black)
                Spacer()
            }
            .padding(.bottom, 32)
            
            //                optionsSelector
            
            VStack(spacing: 16) {
                HStack(alignment: .center, spacing: 32) {
                    VStack(alignment: .leading, spacing: 16) {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Usuários ativos")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.black)
                            
                            Text("Todos os usuários ativos na plataforma da sua empresa nesse momento.")
                                .font(.system(size: 16, weight: .regular))
                                .foregroundColor(.black)
                        }
                        
                        Button {
                            print("Open invite")
                            
                        } label: {
                            HStack {
                                Image(systemName: "person.crop.circle.badge.plus")
                                Text("Convidar pessoas")
                            }
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                            .padding(8)
                            .background(Color.collieAzulEscuro)
                            .cornerRadius(8)
                            
                        }
                        .buttonStyle(.plain)

                    }
                    .padding(.bottom)
                    .frame(maxWidth: 200)
                    
                    VStack(alignment: .leading) {
                        HStack(alignment: .center, spacing: 0) {
                            Circle()
                                .frame(width: 40, height: 40)
                                .opacity(0)
                                .padding(.horizontal)
                            
                            GeometryReader { geometry in
                                HStack(alignment: .top, spacing: 0) {
                                    Text("Nome")
    
                                    Spacer()
                                    
                                    VStack {
                                        Text("E-mail")
                                    }
                                    .frame(width: geometry.size.width * ListComponents.alignWith(component: .email))
                                    
                                    VStack {
                                        Text("Papel")
                                    }
                                    .frame(width: geometry.size.width * ListComponents.alignWith(component: .role))
                                
                                    IconButton(imageSystemName: "trash", action: {})
                                        .opacity(0)
                                        .padding(.leading, 32)
                                }
                            }
                            .padding(.trailing, 36)
                        }
                        .frame(height: 50)
                        .foregroundColor(.black)
                        .font(.system(size: 20, weight: .semibold))
                        
                        ScrollView(.vertical) {
                            VStack {
                                ForEach($viewModel.modelList, id: \.self) { $model in
                                   SettingsUserCell(model: $model, handleUserDeletion: {
                                       viewModel.selectedUserModel = model.userModel
                                       self.showDeleteAlert = true
                                   })
                                }
                            }
                            .padding(.trailing, 20)
                            .padding(.leading, 3)
                            .padding(.vertical, 3)
                            .padding(.bottom, 32)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(maxHeight: 500)
                .padding([.top, .horizontal], 32)
                .background(Color.white)
                .cornerRadius(12)
                
//                HStack {
//                    Text("To do")
//                }
            }
            
            Spacer()
        }
        .padding(.horizontal, 60)
        .padding(.vertical, 32)
        .navigationTitle("Configurações")
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.collieBrancoFundo.ignoresSafeArea())
        .alert(isPresented: $showDeleteAlert) {
            Alert(
                title: Text("Você realmente deseja remover \(viewModel.selectedUserModel?.name ?? "")?"),
                message: Text("Essa ação é definitiva!"),
                primaryButton: .cancel(),
                secondaryButton: .destructive(Text("Deletar")) {
                    viewModel.removeBusinessUser()
                }
            )
        }
    }
    
    var optionsSelector: some View {
        HStack(spacing: 32) {
            ForEach(SettingsOptions.allCases, id: \.self) { option in
                SettingsOptionView(option: option, isSelected: viewModel.isOptionSelected(option), handleSelect: {
                    viewModel.selectOption(option)
                })
            }
            Spacer()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
