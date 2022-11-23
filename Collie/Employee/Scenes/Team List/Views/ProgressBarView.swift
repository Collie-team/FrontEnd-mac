import SwiftUI

struct ProgressBarView: View {
    var doneTasks: Int
    var totalTasks: Int
    @State var percentage: CGFloat = 0.0
    
    var barColor: Color {
        switch percentage {
        case 0...0.5:
            return Color.collieVermelho
        case 0.51...0.99:
            return Color.collieRoxo
        case 1:
            return Color.collieVerde
        default:
            return Color.collieBrancoFundo
        }
    }
    
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
                        .foregroundColor(barColor)
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
