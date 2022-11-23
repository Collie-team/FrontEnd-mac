import SwiftUI

struct CheckBoxView: View {
    var checked: Bool
    var handleCheckToggle: () -> ()
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(checked ? .collieVerde : .collieCinzaClaro)
                .frame(width: 24, height: 24)
            if checked {
                Image(systemName: "checkmark")
                    .collieFont(textStyle: .subtitle)
                    .foregroundColor(.white)
            }
        }
        .frame(width: 28, height: 28)
        .onTapGesture {
            withAnimation {
                handleCheckToggle()
            }
        }
    }
}

struct CheckBoxView_Previews: PreviewProvider {
    static var previews: some View {
        CheckBoxView(checked: true, handleCheckToggle: {})
    }
}
