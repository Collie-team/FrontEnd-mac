//
//  ProfileView.swift
//  Collie
//
//  Created by Pablo Penas on 10/11/22.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var rootViewModel: RootViewModel
    @StateObject var viewModel: ProfileViewModel = ProfileViewModel()
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
                    if let image = viewModel.image {
                        Image(nsImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
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
                            .onTapGesture {
                                viewModel.openFileSelection()
                            }
                    } else {
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
                            .onTapGesture {
                                viewModel.openFileSelection()
                            }
                    }
                }
                Spacer()
                if viewModel.editingMode {
                    EditingFormView(rootViewModelBusinessUser: $rootViewModel.currentBusinessUser, currentUser: rootViewModel.currentUser, editingMode: $viewModel.editingMode)
                        .preferredColorScheme(.dark)
                        .frame(maxHeight: 600)
                } else {
                    DisplayFormView(rootViewModelUser: $rootViewModel.currentUser, rootViewModelBusinessUser: $rootViewModel.currentBusinessUser, currentUser: rootViewModel.currentUser, editingMode: $viewModel.editingMode)
                        .preferredColorScheme(.dark)
                        .frame(maxHeight: 600)
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
                    Button(action: {
                        viewModel.resetPassword(email: rootViewModel.currentUser.email)
                    }) {
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
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
