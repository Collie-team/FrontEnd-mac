//
//  NewUserFormsView.swift
//  Collie
//
//  Created by Pablo Penas on 26/09/22.
//

import SwiftUI

struct NewUserFormsView: View {
    @EnvironmentObject var viewModel: TeamListViewModel
    @State var newUser = UserModel(name: "", email: "", jobDescription: "", personalDescription: "", imageURL: "")
    @Environment(\.presentationMode) var presentationMode
    @State var showList = false
    @State var selectedRole: BusinessUserRoles = .employee
    
    func getRoleLabel(role: BusinessUserRoles) -> String {
        switch role {
        case .admin:
            return "Administrador"
        case .manager:
            return "Gestor"
        case .employee:
            return "Colaborador"
        }
    }
    
    func getItemHeight() -> CGFloat {
        if showList {
            return 130
        } else {
            return 0
        }
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Image(systemName: "person.crop.circle.badge.plus")
                    .font(.system(size: 28))
                VStack(alignment: .leading) {
                    Text("Adicionar pessoas")
                        .font(.system(size: 28, weight: .bold))
                        .padding(.bottom, 8)
                    Text("Convide novos usuários para a plataforma de forma rápida.")
                        .font(.system(size: 16, weight: .regular))
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
                .padding(.trailing, 64)
                HStack(alignment: .top) {
                    TextField("E-mail", text: $newUser.email)
                        .textFieldStyle(.plain)
                        .padding(8)
                        .background(Color.white)
                        .cornerRadius(8)
                        .padding(.bottom, 100)
                    VStack(spacing: 0) {
                        Button(action: {
                            withAnimation {
                                showList.toggle()
                            }
                        }) {
                            VStack(spacing: 0) {
                                HStack {
                                    Text(getRoleLabel(role: selectedRole))
                                        .padding(.vertical)
                                    Spacer()
                                    Image(systemName: showList ? "chevron.up" : "chevron.down")
                                }
                                .font(.system(size: 15))
                            }
                            .frame(height: 40)
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal)
                            .contentShape(Rectangle())
                        }
                        .buttonStyle(.plain)
                        
                        if showList {
                            VStack(spacing: 0) {
                                
                                Divider()
                                    .frame(height: 1)
                                    .padding(.horizontal)
                                ForEach(BusinessUserRoles.allCases, id:\.self) { role in
                                    HStack {
                                        Text(getRoleLabel(role: role))
                                            .onTapGesture {
                                                selectedRole = role
                                                showList.toggle()
                                        }
                                        .font(.system(size: 15))
                                        .padding(.horizontal)
                                        .padding(.vertical, 8)
                                        Spacer()
                                    }
                                }
                                
                            }
                            .frame(maxHeight: 90)
                        }
                    }
                    .background(Color.white)
                    .foregroundColor(.black)
                    .cornerRadius(8)
                }
                .foregroundColor(.black)
                Spacer()
                Text("Enviar")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: 290)
                    .background(Color.collieRoxo)
                    .cornerRadius(8)
                    .disabled(verifyEmail(email: newUser.email))
                    .onTapGesture {
                        viewModel.inviteUser(userToAdd: newUser, role: selectedRole)
                    }
            }
            .padding(.horizontal, 36)
            .padding(.bottom)
        }
        .background(Color.collieCinzaClaro)
    }
    
    func verifyEmail(email: String) -> Bool {
        return !NSPredicate(format:"SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}").evaluate(with: email)
    }
}

struct NewUserFormsView_Previews: PreviewProvider {
    static var previews: some View {
        NewUserFormsView()
            .environmentObject(TeamListViewModel())
    }
}
