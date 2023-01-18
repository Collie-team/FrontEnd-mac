import SwiftUI

struct OnboardingCardView: View {
    var title: String
    var subtitles: [String]
    var currentIndex: Int
    var pagesCount: Int
    var previousPageFunction: () -> ()
    var nextPageFunction: () -> ()
    var shouldShowPreviousButton: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Spacer()
                Text("\(currentIndex + 1)/\(pagesCount)")
                    .foregroundColor(.black)
                    .collieFont(textStyle: .regularText)
            }
            Text(title)
                .collieFont(textStyle: .title)
                .foregroundColor(.black)
                .padding(.bottom, 32)
            
            ForEach(subtitles, id: \.self) { subtitle in
                HStack(alignment: .top, spacing: 16) {
                    Image("starIcon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 22)
                    Text(subtitle)
                        .collieFont(textStyle: .regularText)
                        .foregroundColor(.black)
                }
            }
            
            Spacer()
            
            HStack {
                Button {
                    previousPageFunction()
                } label: {
                    HStack {
                        Image(systemName: "arrow.left")
                        Text("anterior")
                    }
                    .foregroundColor(.collieAzulEscuro)
                    .collieFont(textStyle: .subtitle)
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .cornerRadius(8)
                    .modifier(CustomBorder())
                    .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                .opacity(shouldShowPreviousButton ? 1 : 0)
                
                Spacer()
                Button {
                    nextPageFunction()
                } label: {
                    HStack(spacing: 8) {
                        Text("próximo")
                        Image(systemName: "arrow.right")
                    }
                    .foregroundColor(.white)
                    .collieFont(textStyle: .subtitle)
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(Color.collieAzulEscuro)
                    .cornerRadius(8)
                    .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
            }
        }
        .padding(32)
        .frame(height: 640)
        .frame(maxWidth: 500)
        .background(Color.white)
        .cornerRadius(8)
    }
}

struct OnboardingCardView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingCardView(title: "Título", subtitles: ["Subtítulo 1", "Subtítulo 2"], currentIndex: 1, pagesCount: 5, previousPageFunction: {}, nextPageFunction: {}, shouldShowPreviousButton: false)
    }
}
