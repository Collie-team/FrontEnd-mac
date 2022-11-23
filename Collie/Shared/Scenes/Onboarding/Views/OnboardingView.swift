import SwiftUI

struct OnboardingView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    
    var handleFinish: () -> ()
    
    init(onboardingType: OnboardingType, handleFinish: @escaping () -> ()) {
        self.viewModel = OnboardingViewModel(onboardingType: onboardingType)
        self.handleFinish = handleFinish
    }
    
    var body: some View {
        VStack {
            HStack {
                Image("logoCollieBlack")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200)
                Spacer()
            }
            
            Spacer()
            
            if viewModel.showFinishPage {
                OnboardingFinishedView(
                    handleFinish: handleFinish,
                    handleRestart: viewModel.restartOnboarding
                )
            } else {
                HStack {
                    VStack(spacing: 16) {
                        OnboardingCardView(
                            title: viewModel.currentPage.title,
                            subtitles: viewModel.currentPage.subtitles,
                            currentIndex: viewModel.currentIndex,
                            pagesCount: viewModel.onboardingPages.count,
                            previousPageFunction: viewModel.previousPage,
                            nextPageFunction: viewModel.nextPage,
                            shouldShowPreviousButton: viewModel.shouldShowPreviousButton()
                        )
                        
                        Button {
                            handleFinish()
                            viewModel.skipOnboarding()
                        } label: {
                            Text("pular introdução")
                                .collieFont(textStyle: .subtitle)
                                .foregroundColor(Color.collieAzulEscuro)
                        }
                        .buttonStyle(.plain)

                    }
                    
                    Spacer()
                    
                    Image(viewModel.currentPage.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.leading, 64)
                }
            }
            
            Spacer()
        }
        .padding(.top, 64)
        .padding(.horizontal, 128)
        .background(Color.collieBrancoFundo)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(onboardingType: .employee, handleFinish: {})
    }
}
