import SwiftUI

struct CloseButton: View {
    var handleClose: () -> ()
    
    var body: some View {
        Button {
            handleClose()
        } label: {
            Image(systemName: "xmark.circle")
                .font(.system(size: 21, weight: .bold, design: .default))
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
