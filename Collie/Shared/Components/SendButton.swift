import SwiftUI

struct SendButton: View {
    var label: String
    var isButtonDisabled: Bool
    var handleSend: () -> ()
    
    var body: some View {
        Button {
            handleSend()
        } label: {
            Text(label)
                .font(.system(size: 18, weight: .bold))
                .padding(.vertical, 8)
                .padding(.horizontal, 32)
                .background(isButtonDisabled ? Color.gray : Color.collieAzulEscuro)
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
        SendButton(label: "Salvar", isButtonDisabled: false, handleSend: {})
    }
}
