import SwiftUI

struct ChosenUserCellView: View {
    var user: UserModel
    var onRemove: () -> ()
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .center) {
                UserIconView(user: user)
                    .frame(width: 40, height: 40)
                
                Text(user.name)
                
                Spacer()
                
                Text(user.jobDescription)
                
                Button {
                    withAnimation {
                        onRemove()
                    }
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.collieRoxo)
                }
                .buttonStyle(.plain)

            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            
            Divider()
                .frame(height: 1)
        }
        .font(.system(size: 15))
    }
}

struct ChosenUserCellView_Previews: PreviewProvider {
    static var previews: some View {
        ChosenUserCellView(user: UserModel(name: "André Arns", email: "", jobDescription: "", personalDescription: "", imageURL: ""), onRemove: {})
    }
}
