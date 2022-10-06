//
//  AuthenticationView.swift
//  Collie
//
//  Created by Pablo Penas on 04/10/22.
//

import SwiftUI

struct AuthenticationView: View {
    @StateObject var viewModel = AuthenticationViewModel()
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                Spacer()
                HStack {
                    Image("logoCollieBlack")
                        .resizable()
                        .aspectRatio(204/41.42, contentMode: .fit)
                        .frame(maxWidth: 204)
                    Spacer()
                }
                HStack(spacing: 70) {
                    Image("loginSplashImage")
                        .resizable()
                        .aspectRatio(884.7/724.52, contentMode: .fit)
                        .frame(maxWidth: geometry.size.width * 0.45)
                    if viewModel.authenticationMode == .signup {
                        SignupView()
                            .frame(maxWidth: min(geometry.size.width * 0.45, 530), maxHeight: geometry.size.height * 0.75)
                            .environmentObject(viewModel)
                    } else {
                        LoginView()
                            .frame(maxWidth: min(geometry.size.width * 0.45, 530), maxHeight: geometry.size.height * 0.75)
                            .environmentObject(viewModel)
                    }
                }
                Spacer()
                Spacer()
            }
            .padding()
            .padding(.leading, 48)
            .background(Color.collieBranco)
        }
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
    }
}
