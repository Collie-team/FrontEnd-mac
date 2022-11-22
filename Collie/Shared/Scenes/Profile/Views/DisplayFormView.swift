//
//  DisplayFormView.swift
//  Collie
//
//  Created by Pablo Penas on 14/11/22.
//

import SwiftUI

struct DisplayFormView: View {
    @Binding var rootViewModelUser: UserModel
    @Binding var rootViewModelBusinessUser: BusinessUser?
    @State var currentUser: UserModel
    @Binding var editingMode: Bool
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    editingMode = true
                }) {
                    Text("Editar \(Image(systemName: "square.and.pencil"))")
                        .foregroundColor(Color.collieRoxo)
                        .collieFont(textStyle: .smallTitle)
                }
                .buttonStyle(.plain)
                .contentShape(Rectangle())
            }
            VStack {
                VStack(alignment: .leading) {
                    Text("Nome do usuário")
                        .collieFont(textStyle: .regularText)
                    HStack {
                        Text(currentUser.name)
                            .collieFont(textStyle: .smallTitle)
                        Spacer()
                    }
                    Divider()
                }
                VStack(alignment: .leading) {
                    
                    Text("Cargo")
                        .collieFont(textStyle: .regularText)
                    HStack {
                        Text(currentUser.jobDescription == "" ? "Sem cargo" : currentUser.jobDescription)
                            .collieFont(textStyle: .subtitle)
                        Spacer()
                    }
                    Divider()
                }
                
                VStack(alignment: .leading) {
                    Text("Breve descrição")
                        .collieFont(textStyle: .regularText)
                    HStack {
                        Text(currentUser.personalDescription == "" ? "Sem descrição" : currentUser.personalDescription)
                            .collieFont(textStyle: .subtitle)
                        Spacer()
                    }
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
                            .collieFont(textStyle: .regularText)
                        Spacer()
                    }
                }
            }
            .frame(maxWidth: 600)
        }
        .onChange(of: rootViewModelUser) { updatedUser in
            currentUser = updatedUser
        }
    }
}

struct DisplayFormView_Previews: PreviewProvider {
    static var previews: some View {
        DisplayFormView(rootViewModelUser: .constant(UserModel(id: "", name: "", email: "", jobDescription: "", personalDescription: "", imageURL: "")), rootViewModelBusinessUser: .constant(BusinessUser(userId: "", businessId: "", role: .admin, userTasks: [])), currentUser: UserModel(id: "", name: "", email: "", jobDescription: "", personalDescription: "", imageURL: ""), editingMode: .constant(true))
    }
}
