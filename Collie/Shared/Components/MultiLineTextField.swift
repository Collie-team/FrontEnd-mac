import SwiftUI

struct MultiLineTextField: View {
    @Binding var text: String
    var showPlaceholderWhen: Bool
    var placeholderText: String
    
    var body: some View {
        ZStack(alignment: .top) {
            TextEditor(text: $text)
                .tint(.collieRosaEscuro)
                .frame(height: 80)
                .font(.system(size: 16))
                .padding(.top)
                .padding(.horizontal, 8)
            
            if showPlaceholderWhen {
                HStack(spacing: 0) {
                    Text(placeholderText)
                        .padding(.top)
                        .padding(.horizontal, 12)
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                        .contentShape(NoShape())
                    Spacer()
                }
            }
        }
        .background(Color.white)
        .cornerRadius(8)
    }
}

struct NoShape: Shape {
    func path(in rect: CGRect) -> Path {
        return Path()
    }
}

struct MultiLineTextField_Previews: PreviewProvider {
    static var previews: some View {
        MultiLineTextField(text: .constant("Text"), showPlaceholderWhen: true, placeholderText: "Descrição")
    }
}
