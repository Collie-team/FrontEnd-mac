import SwiftUI

struct CategoryCard: View {
    var category: TaskCategory
    var onTap: () -> ()
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: category.systemImageName)
            Text(category.name)
            Spacer()
        }
        .font(.system(size: 16, weight: .bold))
        .foregroundColor(.white)
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(category.color)
        .cornerRadius(8)
        .onTapGesture {
            onTap()
        }
    }
}

struct CategoryCard_Previews: PreviewProvider {
    static var previews: some View {
        CategoryCard(category: .init(name: "Inclusão", colorName: "roxo", systemImageName: "star.fill"), onTap: {})
    }
}
