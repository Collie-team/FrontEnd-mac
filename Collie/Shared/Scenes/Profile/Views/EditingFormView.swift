//
//  EditingFormView.swift
//  Collie
//
//  Created by Pablo Penas on 14/11/22.
//

import SwiftUI

struct EditingFormView: View {
    @EnvironmentObject var rootViewModel: RootViewModel
    @Binding var rootViewModelBusinessUser: BusinessUser?
    @State var currentUser: UserModel
    @Binding var editingMode: Bool
    var body: some View {
        VStack {
            HStack {
                Spacer()
            }
            VStack {
                VStack(alignment: .leading) {
                    Text("Nome do usuário")
                        .font(.system(size: 15))
                    CustomTextField("Nome", text: $currentUser.name)
                    Divider()
                }
                VStack(alignment: .leading) {
                    
                    Text("Cargo")
                        .font(.system(size: 15))
                    CustomTextField("Cargo", text: $currentUser.jobDescription)
                    Divider()
                }
                
                VStack(alignment: .leading) {
                    Text("Breve descrição")
                        .font(.system(size: 15))
                    CustomTextField("Description", text: $currentUser.personalDescription)
                    Divider()
                }
                
                VStack(alignment: .leading) {
//                    Text("Data de entrada")
//                        .font(.system(size: 15))
//                    HStack {
//                        Text("17/04/2022")
//                            .font(.system(size: 17))
//                        Spacer()
//                    }
//                    Divider()
                    Text("Papel")
                        .font(.system(size: 15))
                    HStack {
                        Text(rootViewModelBusinessUser!.role.getRoleText())
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
                            rootViewModel.updateUser(userData: currentUser)
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
            }
            .frame(maxWidth: 600)
        }
    }}

struct EditingFormView_Previews: PreviewProvider {
    static var previews: some View {
        EditingFormView(rootViewModelBusinessUser: .constant(nil), currentUser: UserModel(id: "", name: "", email: "", jobDescription: "", personalDescription: "", imageURL: ""), editingMode: .constant(true))
    }
}
