import SwiftUI

struct ChangePhotoIcon: View {
    var body: some View {
        Image(systemName: "camera.fill")
            .foregroundColor(Color.collieRoxo)
            .collieFont(textStyle: .title)
            .cornerRadius(8)
            .frame(width: 60, height: 60)
            .background(Color.white)
            .cornerRadius(8)
            .modifier(CustomBorder())
            .offset(x: 100, y: 100)
    }
}

struct ChangePhotoIcon_Previews: PreviewProvider {
    static var previews: some View {
        ChangePhotoIcon()
            .frame(width: 400, height: 400)
            .background(Color.collieVermelho)
    }
}
