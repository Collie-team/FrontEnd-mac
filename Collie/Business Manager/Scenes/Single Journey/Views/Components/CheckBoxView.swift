import SwiftUI

struct CheckBoxView: View {
    var checked: Bool
    var handleCheckToggle: () -> ()
    
    let green = Color(red: 77/255, green: 174/255, blue: 0/255)
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(checked ? green : .collieCinzaClaro)
                .frame(width: 24, height: 24)
                .overlay {
                    Circle()
                        .stroke(Color.collieCinzaBorda, lineWidth: 2)
                }
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
                print("Check toggle")
            }
        }
    }
}

struct CheckBoxView_Previews: PreviewProvider {
    static var previews: some View {
        CheckBoxView(checked: true, handleCheckToggle: {})
    }
}
