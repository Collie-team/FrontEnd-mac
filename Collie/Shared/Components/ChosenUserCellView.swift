import SwiftUI

struct ChosenUserCellView: View {
    var user: UserModel
    var onRemove: () -> ()
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .center) {
                UserIconView(user: user)
                    .frame(width: 30, height: 30)
                
                Text(user.name)
                
                Spacer()
                
                Text(user.jobDescription)
                
                Button {
                    withAnimation {
                        onRemove()
                    }
                } label: {
                    Image(systemName: "xmark")
                        .collieFont(textStyle: .subtitle)
                        .foregroundColor(.collieRoxo)
                }
                .buttonStyle(.plain)

            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            
            Divider()
                .frame(height: 1)
        }
        .collieFont(textStyle: .regularText)
    }
}

struct ChosenUserCellView_Previews: PreviewProvider {
    static var previews: some View {
        ChosenUserCellView(user: UserModel(name: "André Arns", email: "", jobDescription: "", personalDescription: "", imageURL: ""), onRemove: {})
    }
}
