import SwiftUI

struct CustomBorder: ViewModifier {
    func body(content: Content) -> some View {
        content
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.collieCinzaBorda, lineWidth: 2)
            }
    }
}
