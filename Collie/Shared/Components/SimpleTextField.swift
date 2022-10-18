import SwiftUI

struct SimpleTextField: View {
    @Binding var text: String
    var showPlaceholderWhen: Bool
    var placeholderText: String
    
    var body: some View {
        TextField("", text: $text)
            .placeholder(when: showPlaceholderWhen) {
                Text(placeholderText)
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
            }
            .font(.system(size: 16))
            .padding(.horizontal)
            .tint(.collieRosaEscuro)
            .textFieldStyle(.plain)
            .frame(height: 40)
            .background(Color.white)
            .foregroundColor(.black)
            .cornerRadius(8)
    }
}

struct SimpleTextField_Previews: PreviewProvider {
    static var previews: some View {
        SimpleTextField(text: .constant("Text"), showPlaceholderWhen: true, placeholderText: "Título")
    }
}
