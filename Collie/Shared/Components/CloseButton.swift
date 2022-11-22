import SwiftUI

struct CloseButton: View {
    var handleClose: () -> ()
    
    var body: some View {
        Button {
            handleClose()
        } label: {
            Image(systemName: "xmark.circle")
                .collieFont(textStyle: .smallTitle)
                .foregroundColor(.white)
        }
        .buttonStyle(.plain)
    }
}

struct CloseButton_Previews: PreviewProvider {
    static var previews: some View {
        CloseButton(handleClose: {})
    }
}
