import SwiftUI

struct WorkspaceButton: View {
    var title: String
    var action: () -> ()
    
    var body: some View {
        Button(action: {
            action()
        }) {
            Text(title)
                .foregroundColor(.white)
                .collieFont(textStyle: .subtitle)
                .contentShape(Rectangle())
                .padding(.vertical)
                .frame(maxWidth: .infinity)
                .background(Color.collieAzulEscuro)
                .cornerRadius(8)
        }
        .buttonStyle(.plain)
    }
}
