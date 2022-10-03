//
//  ProgressBarView.swift
//  Collie
//
//  Created by Pablo Penas on 26/09/22.
//

import SwiftUI

extension Color {
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}

struct ProgressBarView: View {
    @State var percentage = CGFloat.random(in: 0...1)
    var body: some View {
        HStack {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(maxWidth: .infinity, maxHeight: 12)
                        .foregroundColor(.gray)
                        .cornerRadius(6)
                    Rectangle()
                        .frame(maxWidth: geometry.size.width * percentage, maxHeight: 12)
                        .foregroundColor(Color.random)
                        .cornerRadius(6)
                }
                .frame(maxHeight: .infinity)
            }
                
            Text("\(Int(100 * percentage))%")
        }
    }
}

struct ProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBarView()
    }
}
