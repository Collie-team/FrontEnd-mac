//
//  CustomSecureView.swift
//  Collie
//
//  Created by Pablo Penas on 06/10/22.
//

import SwiftUI

struct CustomSecureView: View {
    @Binding private var text: String
    @State private var isSecured: Bool = true
    private var title: String
    
    init(_ title: String, text: Binding<String>) {
        self.title = title
        self._text = text
    }
    
    var body: some View {
        ZStack(alignment: .trailing) {
            Group {
                if isSecured {
                    SecureField(title, text: $text)
                        .textFieldStyle(.plain)
                        .foregroundColor(Color.collieCinzaEscuro)
                        .padding(.horizontal,15)
                        .padding(.vertical, 8)
                } else {
                    TextField(title, text: $text)
                        .textFieldStyle(.plain)
                        .foregroundColor(Color.collieCinzaEscuro)
                        .padding(.horizontal,15)
                        .padding(.vertical, 8)
                }
            }
            .padding(.trailing, 32)

            Button(action: {
                isSecured.toggle()
            }) {
                Image(systemName: self.isSecured ? "eye.slash" : "eye")
                    .foregroundColor(Color.collieCinzaEscuro.opacity(0.5))
            }
            .buttonStyle(.plain)
            .padding(.trailing,10)
        }
        .background(Color.collieTextFieldBackground)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .strokeBorder(Color.collieTextFieldBorder, lineWidth: 1)
        )
        .preferredColorScheme(.light)
    }
    
}

struct CustomSecureView_Previews: PreviewProvider {
    static var previews: some View {
        CustomSecureView("Password", text: .constant("Secretpassword"))
            .padding()
            .background(Color.white)
    }
}
