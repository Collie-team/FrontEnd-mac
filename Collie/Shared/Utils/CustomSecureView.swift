//
//  CustomSecureView.swift
//  Collie
//
//  Created by Pablo Penas on 06/10/22.
//

import SwiftUI

struct CustomSecureView: View {
    @FocusState private var isFocused: Bool
    @Binding private var text: String
    private var validationFunction: (() -> Bool)?
    @State private var isSecured: Bool = true
    private var title: String
    
    init(_ title: String, text: Binding<String>, _ validatingFunction: (() -> Bool)? = nil) {
        self.title = title
        self._text = text
        self.validationFunction = validatingFunction
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
                        .focused($isFocused)
                } else {
                    TextField(title, text: $text)
                        .textFieldStyle(.plain)
                        .foregroundColor(Color.collieCinzaEscuro)
                        .padding(.horizontal,15)
                        .padding(.vertical, 8)
                        .focused($isFocused)
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
                .strokeBorder((validationFunction ?? {return true})() ? (isFocused ? Color.collieRoxo : Color.collieTextFieldBorder) : Color.collieVermelho, lineWidth: 1) // Review later, field validation function for email and password confirmation
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
