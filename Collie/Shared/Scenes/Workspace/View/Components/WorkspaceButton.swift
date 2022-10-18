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
                .font(.system(size: 17, weight: .bold))
                .contentShape(Rectangle())
                .padding(.vertical)
                .frame(width: 400)
                .background(Color.collieAzulEscuro)
                .cornerRadius(8)
        }
        .buttonStyle(.plain)
    }
}
