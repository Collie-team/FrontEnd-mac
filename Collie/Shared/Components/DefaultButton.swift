import SwiftUI

struct DefaultButton: View {
    var label: String
    var backgroundColor: Color
    var isButtonDisabled: Bool
    var maxWidth: CGFloat?
    var handleSend: () -> ()
    
    var body: some View {
        Button {
            handleSend()
        } label: {
            Text(label)
                .collieFont(textStyle: .subtitle)
                .padding(.vertical, 12)
                .padding(.horizontal, 32)
                .frame(maxWidth: maxWidth ?? .greatestFiniteMagnitude)
                .background(isButtonDisabled ? Color.gray : backgroundColor)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
        .buttonStyle(.plain)
        .disabled(isButtonDisabled)
        .padding(.top)
    }
}

struct SendButton_Previews: PreviewProvider {
    static var previews: some View {
        DefaultButton(label: "Salvar", backgroundColor: .collieAzulEscuro, isButtonDisabled: false, handleSend: {})
    }
}
