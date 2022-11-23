//
//  NewUserFormsView.swift
//  Collie
//
//  Created by Pablo Penas on 26/09/22.
//

import SwiftUI

struct NewUserFormsView: View {
    @EnvironmentObject var rootViewModel: RootViewModel
    @State var newUser = UserModel(name: "", email: "", jobDescription: "", personalDescription: "", imageURL: "")
    @Environment(\.presentationMode) var presentationMode
    @State var showList = false
    @State var selectedRole: BusinessUserRoles = .employee
    @State var emailSentLabel: Bool = false {
        didSet {
            if emailSentLabel == true {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.emailSentLabel = false
                }
            }
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
                    .collieFont(textStyle: .title)
                VStack(alignment: .leading) {
                    Text("Adicionar pessoas")
                        .collieFont(textStyle: .title)
                        .padding(.bottom, 8)
                    Text("Convide novos usuários para a plataforma de forma rápida.")
                        .collieFont(textStyle: .regularText)
                }
                Spacer()
                VStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark.circle")
                            .collieFont(textStyle: .title)
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
                .collieFont(textStyle: .regularText)
                .foregroundColor(.black)
                .padding(.trailing, 64)
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 4) {
                        TextField("E-mail", text: $newUser.email)
                            .textFieldStyle(.plain)
                            .padding(8)
                            .background(Color.white)
                            .cornerRadius(8)
                        Text("E-mail enviado!")
                            .font(.system(size: 12))
                            .padding(8)
                            .foregroundColor(Color.collieRoxo)
                            .opacity(emailSentLabel ? 1 : 0)
                    }
                    .padding(.bottom, 100)
                    VStack(spacing: 0) {
                        Button(action: {
                            withAnimation {
                                showList.toggle()
                            }
                        }) {
                            VStack(spacing: 0) {
                                HStack {
                                    Text(selectedRole.getRoleText())
                                        .padding(.vertical)
                                    Spacer()
                                    Image(systemName: showList ? "chevron.up" : "chevron.down")
                                }
                                .collieFont(textStyle: .regularText)
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
                                        Text(role.getRoleText())
                                            .onTapGesture {
                                                selectedRole = role
                                                showList.toggle()
                                        }
                                        .collieFont(textStyle: .regularText)
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
                        rootViewModel.inviteUser(userToAdd: newUser, role: selectedRole) {
                            emailSentLabel = true
                        }
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
            .environmentObject(RootViewModel())
    }
}
