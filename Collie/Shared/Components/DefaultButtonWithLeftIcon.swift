import SwiftUI

struct DefaultButtonWithLeftIcon: View {
    var label: String
    var systemImageName: String
    var onTap: () -> ()
    
    var body: some View {
        Button {
            onTap()
        } label: {
            HStack {
                Image(systemName: "plus")
                Text("Nova tarefa")
            }
            .collieFont(textStyle: .subtitle)
            .padding(8)
            .foregroundColor(.black)
            .frame(height: 45)
            .background(Color.white)
            .cornerRadius(8)
            .modifier(CustomBorder())
        }
        .contentShape(Rectangle())
        .buttonStyle(.plain)
    }
}

struct DefaultButtonWithLeftIcon_Previews: PreviewProvider {
    static var previews: some View {
        DefaultButtonWithLeftIcon(label: "Nova tarefa", systemImageName: "plus", onTap: {})
    }
}
