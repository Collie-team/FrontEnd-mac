//
//  CustomTextFieldStyle.swift
//  Collie
//
//  Created by Pablo Penas on 05/10/22.
//

import Foundation
import SwiftUI

struct CustomTextField: View {
    
    @Binding var text: String
    private var title: String
    
    init(_ title: String, text: Binding<String>) {
        self.title = title
        self._text = text
    }
    var body: some View {
        HStack {
            TextField(title, text: $text)
                .textFieldStyle(PlainTextFieldStyle())
                .foregroundColor(Color.collieCinzaEscuro)
                .padding(.horizontal,15)
                .padding(.vertical, 8)
                .background(Color.collieTextFieldBackground)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .strokeBorder(Color.collieTextFieldBorder, lineWidth: 1)
                )
        }
        .preferredColorScheme(.light)
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField("Password", text: .constant("Pablo"))
            .padding()
            .background(Color.white)
    }
}
