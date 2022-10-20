import SwiftUI

struct CheckBoxView: View {
    @Binding var checked: Bool
    
    let green = Color(red: 77/255, green: 174/255, blue: 0/255)
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(checked ? green : .collieCinzaClaro)
                .frame(width: 24, height: 24)
            if checked {
                Image(systemName: "checkmark")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
            }
        }
        .frame(width: 24, height: 24)
        .onTapGesture {
            withAnimation {
                checked.toggle()
            }
        }
    }
}

struct CheckBoxView_Previews: PreviewProvider {
    static var previews: some View {
        CheckBoxView(checked: .constant(false))
    }
}
