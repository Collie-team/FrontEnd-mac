import SwiftUI

struct LoadingIndicator: View {
    
    var animation: Animation {
        Animation.easeIn(duration: 2.2)
    }
    
    @State var angle = Angle.degrees(0)
    
    var body: some View {
        Image("loadingSprite")
            .resizable()
            .frame(width: 100, height: 100)
            .aspectRatio(contentMode: .fit)
            .rotationEffect(angle)
            .animation(animation.repeatForever(autoreverses: false), value: angle)
            .onAppear {
                angle += Angle.degrees(1080)
            }
    }
}

struct LoadingIndicator_Previews: PreviewProvider {
    static var previews: some View {
        LoadingIndicator()
    }
}
