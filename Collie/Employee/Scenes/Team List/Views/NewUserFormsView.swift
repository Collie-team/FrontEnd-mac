//
//  NewUserFormsView.swift
//  Collie
//
//  Created by Pablo Penas on 26/09/22.
//

import SwiftUI

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

