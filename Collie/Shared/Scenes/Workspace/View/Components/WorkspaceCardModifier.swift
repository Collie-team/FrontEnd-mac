import SwiftUI

struct WorkspaceCardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(32)
            .frame(maxWidth: NSScreen.main!.frame.width > 600 ? (NSScreen.main!.frame.width * 0.6) : .infinity)
            .background(Color.white)
            .cornerRadius(12)
            .shadow(color: .collieAzulEscuro.opacity(0.05), radius: 23, x: 0, y: 4)
            .padding(.bottom, 32)
    }
}
