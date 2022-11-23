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
                .frame(height: 40)
                .background(Color.collieTextFieldBackground)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .strokeBorder(
                            (validationFunction ?? {return true})() ? (isFocused ? Color.collieRoxo : Color.collieCinzaBorda) : Color.collieVermelho, lineWidth: 2)
                )
                .focused($isFocused)
        }
        .preferredColorScheme(.light)
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField("E-mail", text: .constant("Pablo@hotmail.com")) { return true }
            .padding()
            .background(Color.white)
    }
}
