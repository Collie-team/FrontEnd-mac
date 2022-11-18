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
                        Text(currentUser.name)
                            .font(.system(size: 22, weight: .bold))
                        Spacer()
                    }
                    Divider()
                }
                VStack(alignment: .leading) {
                    
                    Text("Cargo")
                        .font(.system(size: 15))
                    HStack {
                        Text(currentUser.jobDescription == "" ? "Sem cargo" : currentUser.jobDescription)
                            .font(.system(size: 17, weight: .bold))
                        Spacer()
                    }
                    Divider()
                }
                
                VStack(alignment: .leading) {
                    Text("Breve descrição")
                        .font(.system(size: 15))
                    HStack {
                        Text(currentUser.personalDescription == "" ? "Sem descrição" : currentUser.personalDescription)
                            .font(.system(size: 17, weight: .bold))
                        Spacer()
                    }
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
