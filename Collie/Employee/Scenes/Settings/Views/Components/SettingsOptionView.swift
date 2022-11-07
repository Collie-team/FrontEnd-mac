import SwiftUI

struct SettingsOptionView: View {
    var option: SettingsOptions
    var isSelected: Bool
    var handleSelect: () -> ()
    
    var body: some View {
        VStack(spacing: 8) {
            Text(option.rawValue)
                .font(.system(size: 21, weight: isSelected ? .bold : .regular))
                .foregroundColor(.black)
            RoundedRectangle(cornerRadius: 8)
                .frame(height: 3)
                .frame(maxWidth: 100)
                .foregroundColor(Color.collieRoxo)
                .opacity(isSelected ? 1 : 0)
        }
        .onTapGesture {
            withAnimation {
                handleSelect()
            }
        }
    }
}

struct SettingsOptionView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsOptionView(option: .general, isSelected: true, handleSelect: {})
    }
}
