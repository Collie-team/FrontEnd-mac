//
//  WorkspaceView.swift
//  Collie
//
//  Created by Pablo Penas on 13/10/22.
//

import SwiftUI

struct WorkspaceView: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Image("logoCollieBlack")
                            .resizable()
                            .aspectRatio(204/41.42, contentMode: .fit)
                            .frame(maxWidth: 204)
                        Spacer()
                    }
                    Spacer()
                }
                VStack(spacing: 80) {
                    VStack {
                        Text("Ih, parece que você ainda não faz parte de nenhum workspace.")
                            .font(.system(size: 34, weight: .bold))
                        Text("Workspaces auxiliam no gerenciamento do time da sua empresa, crie e gerencie seu espaço já!")
                    }
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(140)
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(color: .gray, radius: 4, x: 0, y: 4)
                    
                    Button(action: {}) {
                        Text("Criar Workspace")
                            .foregroundColor(.white)
                            .font(.system(size: 17, weight: .bold))
                    }
                    .buttonStyle(.plain)
                    .padding()
                    .background(Color.collieCinzaEscuro)
                    .cornerRadius(8)
                }
            }
            .padding()
            .padding(.leading, 48)
            .padding(.top, 36)
            .background(Color.collieBranco)
        }
    }
}

struct WorkspaceView_Previews: PreviewProvider {
    static var previews: some View {
        WorkspaceView()
    }
}
