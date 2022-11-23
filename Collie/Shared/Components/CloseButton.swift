import SwiftUI

struct CloseButton: View {
    var handleClose: () -> ()
    
    var body: some View {
        Button {
            handleClose()
        } label: {
            ZStack {
                Circle()
                    .frame(width: 36, height: 36)
                    .foregroundColor(.black.opacity(0.2))
                Image(systemName: "xmark")
                    .collieFont(textStyle: .smallTitle)
                    .foregroundColor(.white)
            }
        }
        .buttonStyle(.plain)
    }
}

struct CloseButton_Previews: PreviewProvider {
    static var previews: some View {
        CloseButton(handleClose: {})
            .background(Color.collieVermelho)
    }
}
