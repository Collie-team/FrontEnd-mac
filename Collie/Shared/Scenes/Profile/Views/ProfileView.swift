//
//  ProfileView.swift
//  Collie
//
//  Created by Pablo Penas on 10/11/22.
//

import SwiftUI

struct ProfileView: View {
    @State var editingMode: Bool = false
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Perfil")
                    .font(.system(size: 40, weight: .bold, design: .default))
                    .foregroundColor(Color.black)
                Spacer()
            }
            .padding(.bottom, 32)
            
            HStack(spacing: 36) {
                VStack(alignment: .leading) {
                    Text("Apresentação")
                        .font(.system(size: 22, weight: .bold))
                    Text("Esses dados são visiveis para todos os responsáveis dentro da plataforma.")
                        .font(.system(size: 15))
                }
                .frame(maxWidth: 315)
                Spacer()
                VStack(alignment: .leading) {
                    Text("Foto de Perfil")
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.collieVermelho)
                        .frame(width: 240, height: 240)
                        .overlay(
                            ZStack {
                                Image(systemName: "camera.fill")
                                    .foregroundColor(Color.collieRoxo)
                                    .font(.system(size: 28))
                            }
                            .frame(width: 60, height: 60)
                            .background(Color.white)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.collieTextFieldBorder, lineWidth: 1)
                            )
                            .offset(x: 100, y: 100)
                        )
                }
                Spacer()
                if editingMode {
                    editingForm
                } else {
                    displayForm
                }
            }
            .frame(maxWidth: .infinity)
            .padding([.top, .horizontal], 32)
            .background(Color.white)
            .cornerRadius(12)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Senha")
                        .font(.system(size: 22, weight: .bold))
                    Text("Altere sua senha e a deixe mais segura. Será necessário uma validação pelo e-mail utilizado na plataforma.")
                        .font(.system(size: 15))
                }
                .frame(maxWidth: 350)
                Spacer()
                HStack {
                    Image(systemName: "lock.fill")
                        .font(.system(size: 28))
                        .foregroundColor(Color.collieTextFieldBorder)
                    Button(action: {}) {
                        Text("Enviar e-mail para alterar senha")
                            .padding(.horizontal, 24)
                            .padding(.vertical, 12)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.collieTextFieldBorder, lineWidth: 1)
                            )
                    }
                    .buttonStyle(.plain)
                    .contentShape(Rectangle())
                }
            }
            .frame(maxWidth: .infinity)
            .padding(32)
            .background(Color.white)
            .cornerRadius(12)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Remover conta")
                        .font(.system(size: 22, weight: .bold))
                    Text("Ao remover sua conta, Todos os seus dados serão apagados da plataforma.")
                        .font(.system(size: 15))
                }
                .frame(maxWidth: 350)
                Spacer()
                Button(action: {}) {
                    Text("Excluir conta")
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                        .cornerRadius(8)
                        .foregroundColor(Color.collieVermelho)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.collieVermelho, lineWidth: 1)
                        )
                }
                .buttonStyle(.plain)
                .contentShape(Rectangle())
            }
            .frame(maxWidth: .infinity)
            .padding(32)
            .background(Color.white)
            .cornerRadius(12)
            
            
            Spacer()
        }
        .padding(.horizontal, 60)
        .padding(.vertical, 32)
        .navigationTitle("Perfil")
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.collieBrancoFundo.ignoresSafeArea())
        //        .alert(isPresented: $showDeleteAlert) {
        //            Alert(
        //                title: Text("Você realmente deseja remover \(viewModel.selectedUserModel?.name ?? "")?"),
        //                message: Text("Essa ação é definitiva!"),
        //                primaryButton: .cancel(),
        //                secondaryButton: .destructive(Text("Deletar")) {
        //                    viewModel.removeBusinessUser()
        //                }
        //            )
        //        }
    }
    
    var displayForm: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    editingMode = true
                }) {
                    Text("Editar \(Image(systemName: "square.and.pencil"))")
                        .foregroundColor(Color.collieRoxo)
                        .font(.system(size: 20))
                }
                .buttonStyle(.plain)
                .contentShape(Rectangle())
            }
            VStack {
                VStack(alignment: .leading) {
                    Text("Nome do usuário")
                        .font(.system(size: 15))
                    HStack {
                        Text("Laura Gomes")
                            .font(.system(size: 22, weight: .bold))
                        Spacer()
                    }
                    Divider()
                }
                VStack(alignment: .leading) {
                    
                    Text("Cargo")
                        .font(.system(size: 15))
                    HStack {
                        Text("Sem cargo")
                            .font(.system(size: 17, weight: .bold))
                        Spacer()
                    }
                    Divider()
                }
                
                VStack(alignment: .leading) {
                    Text("Breve descrição")
                        .font(.system(size: 15))
                    HStack {
                        Text("Sem descrição")
                            .font(.system(size: 17, weight: .bold))
                        Spacer()
                    }
                    Divider()
                }
                
                VStack(alignment: .leading) {
                    Text("Data de entrada")
                        .font(.system(size: 15))
                    HStack {
                        Text("17/04/2022")
                            .font(.system(size: 17))
                        Spacer()
                    }
                    Divider()
                    Text("Papel")
                        .font(.system(size: 15))
                    HStack {
                        Text("Colaborador")
                            .font(.system(size: 17))
                        Spacer()
                    }
                }
                .padding(.bottom, 60)
            }
            .frame(maxWidth: 600)
        }
    }
    
    var editingForm: some View {
        VStack {
            HStack {
                Spacer()
            }
            VStack {
                VStack(alignment: .leading) {
                    Text("Nome do usuário")
                        .font(.system(size: 15))
                    CustomTextField("Nome", text: .constant("Laura Gomes"))
                    Divider()
                }
                VStack(alignment: .leading) {
                    
                    Text("Cargo")
                        .font(.system(size: 15))
                    CustomTextField("Cargo", text: .constant("Sem cargo"))
                    Divider()
                }
                
                VStack(alignment: .leading) {
                    Text("Breve descrição")
                        .font(.system(size: 15))
                    CustomTextField("Description", text: .constant("Sem descrição"))
                    Divider()
                }
                
                VStack(alignment: .leading) {
                    Text("Data de entrada")
                        .font(.system(size: 15))
                    HStack {
                        Text("17/04/2022")
                            .font(.system(size: 17))
                        Spacer()
                    }
                    Divider()
                    Text("Papel")
                        .font(.system(size: 15))
                    HStack {
                        Text("Colaborador")
                            .font(.system(size: 17))
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Button(action: {
                            editingMode = false
                        }) {
                            Text("Reverter alterações")
                                .padding(.horizontal, 24)
                                .padding(.vertical, 12)
                        }
                        .buttonStyle(.plain)
                        .contentShape(Rectangle())
                        .background(.white)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                        
                        Button(action: {
                            editingMode = false
                        }) {
                            Text("Salvar alterações")
                                .padding(.horizontal, 24)
                                .padding(.vertical, 12)
                        }
                        .buttonStyle(.plain)
                        .contentShape(Rectangle())
                        .background(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                    }
                }
                .padding(.bottom, 60)
            }
            .frame(maxWidth: 600)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
