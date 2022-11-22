import SwiftUI

struct InviteUserButton: View {
    var onTap: () -> ()
    
    var body: some View {
        Button {
           onTap()
        } label: {
            HStack {
                Image(systemName: "person.crop.circle.badge.plus")
                Text("Convidar pessoas")
            }
            .collieFont(textStyle: .subtitle)
            .foregroundColor(.white)
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .background(Color.collieAzulEscuro)
            .cornerRadius(8)
        }
        .buttonStyle(.plain)
    }
}

struct InviteUserButton_Previews: PreviewProvider {
    static var previews: some View {
        InviteUserButton {
            
        }
    }
}
