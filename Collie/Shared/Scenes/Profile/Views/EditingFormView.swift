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
                        .collieFont(textStyle: .regularText)
                    CustomTextField("Nome", text: $currentUser.name)
                    Divider()
                }
                VStack(alignment: .leading) {
                    
                    Text("Cargo")
                        .collieFont(textStyle: .regularText)
                    CustomTextField("Cargo", text: $currentUser.jobDescription)
                    Divider()
                }
                
                VStack(alignment: .leading) {
                    Text("Breve descrição")
                        .collieFont(textStyle: .regularText)
                    CustomTextField("Description", text: $currentUser.personalDescription)
                    Divider()
                }
                
                VStack(alignment: .leading) {
//                    Text("Data de entrada")
//                        .collieFont(textStyle: .regularText)
//                    HStack {
//                        Text("17/04/2022")
//                            .collieFont(textStyle: .regularText)
//                        Spacer()
//                    }
//                    Divider()
                    Text("Papel")
                        .collieFont(textStyle: .regularText)
                    HStack {
                        Text(rootViewModelBusinessUser!.role.getRoleText())
                            .collieFont(textStyle: .subtitle)
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
