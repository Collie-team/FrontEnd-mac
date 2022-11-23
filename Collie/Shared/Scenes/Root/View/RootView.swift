import SwiftUI

struct RootView: View {
    @StateObject var viewModel = RootViewModel()
    var body: some View {
        getCurrentView()
            .onAppear {
                viewModel.checkIfUserIsLoggedIn()
            }
    }
    
    @ViewBuilder func getCurrentView() -> some View {
        switch viewModel.navigationState {
        case .authentication:
            AuthenticationView(handleSingIn: viewModel.handleAuthentication)
                .environmentObject(viewModel)
        case .workspace:
            WorkspaceView()
                .environmentObject(viewModel)
        case.employee:
            EmployeeSidebarView(handleSignOut: {})
                .environmentObject(viewModel)
        case .manager:
            BusinessSidebarView(handleSignOut: {})
                .environmentObject(viewModel)
        case .managerOnboarding:
            OnboardingView(onboardingType: .businessManager, handleFinish: {
                viewModel.navigationState = .manager
            })
            .environmentObject(viewModel)
        case .employeeOnboarding:
            OnboardingView(onboardingType: .employee, handleFinish: {
                viewModel.navigationState = .employee
            })
            .environmentObject(viewModel)
        }
    }
}
