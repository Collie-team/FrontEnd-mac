import SwiftUI

struct SimpleButton: View {
    var label: String
    var onTap: () -> ()
    
    var body: some View {
        Button {
            onTap()
        } label: {
            Text(label)
                .collieFont(textStyle: .subtitle)
                .padding(.vertical, 8)
                .padding(.horizontal, 32)
                .foregroundColor(.black)
                .frame(height: 45)
                .background(Color.white)
                .cornerRadius(8)
                .modifier(CustomBorder())
        }
        .contentShape(Rectangle())
        .buttonStyle(.plain)
    }
}

struct SimpleButton_Previews: PreviewProvider {
    static var previews: some View {
        SimpleButton(label: "Salvar alterações", onTap: {})
    }
}
