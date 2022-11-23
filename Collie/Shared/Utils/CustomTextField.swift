//
//  CustomTextFieldStyle.swift
//  Collie
//
//  Created by Pablo Penas on 05/10/22.
//

import Foundation
import SwiftUI

struct CustomTextField: View {
    @FocusState private var isFocused: Bool
    @Binding var text: String
    private var validationFunction: (() -> Bool)?
    private var title: String
    
    init(_ title: String, text: Binding<String>, _ validatingFunction: (() -> Bool)? = nil) {
        self.title = title
        self._text = text
        self.validationFunction = validatingFunction
    }
    var body: some View {
        HStack {
            TextField(title, text: $text)
                .collieFont(textStyle: .regularText)
                .textFieldStyle(PlainTextFieldStyle())
                .foregroundColor(Color.collieCinzaEscuro)
                .padding(.horizontal,15)
                .padding(.vertical, 8)
                .background(Color.collieTextFieldBackground)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .strokeBorder(
                            (validationFunction ?? {return true})() ? (isFocused ? Color.collieRoxo : Color.collieTextFieldBorder) : Color.collieVermelho, lineWidth: 1) // Review later, field validation function for email and password confirmation
                )
                .focused($isFocused)
        }
        .preferredColorScheme(.light)
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField("E-mail", text: .constant("Pablo@hotmail.com")) { return false }
            .padding()
            .background(Color.white)
    }
}
