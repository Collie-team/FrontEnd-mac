import SwiftUI

struct DestructiveButton: View {
    var label: String
    var onTap: () -> ()
    
    var body: some View {
        Button(action: {
            onTap()
        }) {
            Text(label)
                .collieFont(textStyle: .subtitle)
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                .background(Color.collieVermelho)
                .cornerRadius(8)
                .foregroundColor(.white)
        }
        .buttonStyle(.plain)
        .contentShape(Rectangle())
    }
}

struct DestructiveButton_Previews: PreviewProvider {
    static var previews: some View {
        DestructiveButton(label: "Excluir conta", onTap: {})
    }
}
