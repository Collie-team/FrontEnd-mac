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
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Image(systemName: "person.crop.circle.badge.plus")
                    .font(.system(size: 28))
                VStack(alignment: .leading) {
                    Text("Adicionar pessoas")
                        .font(.system(size: 28, weight: .bold))
                        .padding(.bottom, 8)
                    Text("Convide rapidamente novos usuários para a plataforma, através de um e-mail padrão.")
                        .font(.system(size: 16, weight: .semibold))
                }
                Spacer()
                VStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark.circle")
                            .font(.system(size: 32))
                    }
                    .buttonStyle(.plain)
                    .alignmentGuide(.top) { view in view[.bottom] }
                    .padding(.top, 12)
                }
            }
            .foregroundColor(.white)
            .padding(.bottom, 32)
            .frame(maxWidth: .infinity)
            .padding(.leading, 36)
            .padding(.trailing, 16)
            .background(Color.collieRoxo)
            
            
            
            VStack {
                HStack {
                    Image(systemName: "person.2.fill")
                    Text("Enviar convite ao novo colaborador")
                        .fontWeight(.semibold)
                    Spacer()
                }
                .font(.system(size: 17))
                .foregroundColor(.black)
                HStack {
                    TextField("E-mail", text: .constant("placeholder@collie.com"))
                        .textFieldStyle(.plain)
                        .padding(8)
                        .background(Color.white)
                        .cornerRadius(8)
                    HStack {
                        Text("Cargo")
                        Image(systemName: "chevron.down")
                    }
                    .padding(8)
                    .background(Color.white)
                    .cornerRadius(8)
                }
                .foregroundColor(.black)
                Spacer()
                Button(action: {}) {
                    Text("Enviar")
                        .foregroundColor(.black)
                        .padding()
                }
                .contentShape(Rectangle())
                .buttonStyle(.plain)
                .background(Color.blue)
            }
            .padding(.horizontal, 36)
            .padding(.bottom)
        }
        .background(Color.collieCinzaClaro)
    }
}

struct NewUserFormsView_Previews: PreviewProvider {
    static var previews: some View {
        NewUserFormsView()
    }
}
