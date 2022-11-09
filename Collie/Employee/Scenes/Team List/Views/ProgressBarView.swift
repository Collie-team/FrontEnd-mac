//
//  ProgressBarView.swift
//  Collie
//
//  Created by Pablo Penas on 26/09/22.
//

import SwiftUI

extension Color {
    static var random: Color = Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
}

struct ProgressBarView: View {
    var doneTasks: Int
    var totalTasks: Int
    @State var percentage: CGFloat = 0.0
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
            .onAppear {
                percentage = totalTasks > 0 ? CGFloat(doneTasks) / CGFloat(totalTasks) : 1
            }
                
            Text("\(Int(100 * percentage))%")
                .opacity(0.5)
        }
    }
}

struct ProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBarView(doneTasks: 10, totalTasks: 14)
    }
}
