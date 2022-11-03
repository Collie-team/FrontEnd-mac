//
//  RootView.swift
//  Collie
//
//  Created by Pablo Penas on 18/10/22.
//

import SwiftUI

struct RootView: View {
    @StateObject var viewModel = RootViewModel()
    var body: some View {
        getCurrentView()
    }
    
    @ViewBuilder func getCurrentView() -> some View {
        switch viewModel.navigationState {
        case .authentication:
            AuthenticationView(handleSingIn: viewModel.handleAuthentication)
        case .workspace:
            WorkspaceView()
                .environmentObject(viewModel)
        case.employee:
            EmployeeSidebarView(handleSignOut: {})
        case .manager:
            // TODO: Business injection
            BusinessManagerSidebarView(handleSignOut: {})
        case .managerOnboarding:
            OnboardingView(onboardingType: .businessManager, handleFinish: {
                viewModel.navigationState = .manager
            })
        case .employeeOnboarding:
            OnboardingView(onboardingType: .employee, handleFinish: {
                viewModel.navigationState = .employee
            })
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
