import SwiftUI

struct TitleTextField: View {
    @Binding var text: String
    var showPlaceholderWhen: Bool
    var placeholderText: String
    
    var body: some View {
        TextField("", text: $text)
            .placeholder(when: showPlaceholderWhen) {
                Text(placeholderText)
                    .font(.system(size: 21))
                    .bold()
                    .foregroundColor(.gray)
            }
            .font(.system(size: 21, weight: .bold))
            .padding(.horizontal)
            .tint(.collieRosaEscuro)
            .textFieldStyle(.plain)
            .frame(height: 40)
            .background(Color.white)
            .foregroundColor(.black)
            .cornerRadius(8)
    }
}

struct TitleTextField_Previews: PreviewProvider {
    static var previews: some View {
        TitleTextField(text: .constant("Text"), showPlaceholderWhen: true, placeholderText: "Título")
    }
}
