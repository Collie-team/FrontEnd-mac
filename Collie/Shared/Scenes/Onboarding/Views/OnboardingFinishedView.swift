import SwiftUI

struct OnboardingFinishedView: View {
    var handleFinish: () -> ()
    var handleRestart: () -> ()
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Prontinho!")
                .font(.system(size: 34, weight: .bold))
                .foregroundColor(Color.collieAzulEscuro)
            Text("Agora que já conhece um pouco o seu novo workspace, já pode começar a usar! \nTenha uma boa jornada com a Collie!")
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
                .font(.system(size: 21))
            Image("onboardingFinished")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            HStack(spacing: 16) {
                Button {
                    handleRestart()
                } label: {
                    Text("rever introdução")
                        .padding(.vertical, 8)
                        .padding(.horizontal, 32)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.collieAzulEscuro)
                        .cornerRadius(8)
                        .modifier(CustomBorder())
                }
                .buttonStyle(.plain)
                
                Button {
                    handleFinish()
                } label: {
                    Text("começar")
                        .padding(.vertical, 8)
                        .padding(.horizontal, 100)
                        .background(Color.collieAzulEscuro)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .buttonStyle(.plain)
            }

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.top, 64)
        .padding(.bottom, 128)
        .background(Color.collieBrancoFundo)
    }
}

struct OnboardingFinishedView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingFinishedView(handleFinish: {}, handleRestart: {})
    }
}
