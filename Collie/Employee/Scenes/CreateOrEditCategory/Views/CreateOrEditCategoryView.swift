import SwiftUI

struct CreateOrEditCategoryView: View {
    @ObservedObject var viewModel = CreateOrEditCategoryViewModel()
    
    var category: TaskCategory?
    var handleClose: () -> ()
    var handleCategorySave: (TaskCategory) -> ()
    var handleCategoryDelete: (TaskCategory) -> ()
    
    init(
        category: TaskCategory?,
        handleClose: @escaping () -> (),
        handleCategorySave: @escaping (TaskCategory) -> (),
        handleCategoryDelete: @escaping (TaskCategory) -> ()
    ) {
        self.category = category
        self.handleClose = handleClose
        self.handleCategorySave = handleCategorySave
        self.handleCategoryDelete = handleCategoryDelete
        if let category = category {
            viewModel.categoryName = category.name
            viewModel.systemImageName = category.systemImageName
            viewModel.colorName = category.colorName
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                CloseButton(handleClose: handleClose)
            }
            .padding(.top, 8)
            .padding(.trailing, 8)
            
            VStack(spacing: 16) {
                HStack {
                    TitleTextField(text: $viewModel.categoryName, showPlaceholderWhen: viewModel.categoryName.isEmpty, placeholderText: "Nome da categoria")
                    
                    if let category = category {
                        IconButton(imageSystemName: "trash") {
                            handleCategoryDelete(category)
                        }
                    }
                }
                .padding(.bottom, 40)
                
                HStack(alignment: .top, spacing: 16) {
                    VStack(alignment: .leading, spacing: 8) {
                        TitleWithIconView(systemImageName: "paintpalette.fill", label: "Cor")
                        Text("Cor destinada para representar todos os eventos e tarefas de uma mesma categorias.")
                            .font(.system(size: 13, weight: .regular))
                            .foregroundColor(.black.opacity(0.5))
                            .lineLimit(2)
                            .minimumScaleFactor(0.5)
                            .multilineTextAlignment(.leading)
                    }
                    .frame(maxWidth: 300)
                    Spacer()
                    HStack {
                        ForEach(viewModel.colorNamesArray, id: \.self) { colorName in
                            CategoryColorView(colorName: colorName, isSelected: viewModel.isColorSelected(with: colorName)) {
                                viewModel.selectColor(with: colorName)
                            }
                        }
                    }
                }
                
                Divider()
                
                HStack(alignment: .top, spacing: 16) {
                    VStack(alignment: .leading, spacing: 8) {
                        TitleWithIconView(systemImageName: "star.fill", label: "Ícone")
                        Text("Simbolo para representar a categoria de maneira rápida.")
                            .font(.system(size: 13, weight: .regular))
                            .foregroundColor(.black.opacity(0.5))
                            .lineLimit(2)
                            .minimumScaleFactor(0.5)
                            .multilineTextAlignment(.leading)
                    }
                    .frame(maxWidth: 300)
                    Spacer()
                    
                    HStack {
                        ForEach(viewModel.systemNamesArray, id: \.self) { systemName in
                            CategoryIconView(systemImageName: systemName, isSelected: viewModel.isIconSelected(with: systemName)) {
                                viewModel.selectIcon(with: systemName)
                            }
                        }
                    }
                }
                

                SendButton(label: "salvar categoria", isButtonDisabled: false, handleSend: {
                    // TO DO
                    handleClose()
                })
            }
            .padding(.vertical)
            .padding(.horizontal, 32)
        }
        .background(
            VStack(spacing: 0) {
                viewModel.getColor(for: viewModel.colorName)
                    .frame(height: 130)
                Color.white
            }
        )
        .cornerRadius(8)
    }
}

struct CategoryIconView: View {
    var systemImageName: String
    var isSelected: Bool
    var onTap: () -> ()
    
    var body: some View {
        Image(systemName: systemImageName)
            .font(.system(size: 18, weight: isSelected ? .bold : .regular))
            .frame(width: 40, height: 40)
            .background(isSelected ? Color.collieCinzaClaro : .white)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(isSelected ? .white : Color.collieCinzaClaro, lineWidth: 2)
            )
            .onTapGesture {
                onTap()
            }
    }
}

struct CategoryColorView: View {
    var colorName: String
    var isSelected: Bool
    var onTap: () -> ()
    
    func getColor(for name: String) -> Color {
        switch name {
        case "rosa":
            return Color.collieRosaEscuro
        case "vermelho":
            return Color.collieVermelho
        case "amarelo":
            return Color.collieAmareloForte
        case "verde":
            return Color.collieVerde
        case "azulClaro":
            return Color.collieAzulClaro
        case "azulEscuro":
            return Color.collieAzulEscuro
        case "roxo":
            return Color.collieRoxo
        default:
            return Color.gray
        }
    }
    
    var body: some View {
        Circle()
            .foregroundColor(getColor(for: colorName))
            .frame(width: 40, height: 40)
            .overlay(
                Circle()
                    .stroke(isSelected ? .white : Color.collieCinzaClaro, lineWidth: 2)
            )
            .onTapGesture {
                onTap()
            }
    }
}

struct CreateOrEditCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CreateOrEditCategoryView(category: TaskCategory(name: "Cultura organizacional", colorName: "roxo", systemImageName: "lock"), handleClose: {}, handleCategorySave: {_ in}, handleCategoryDelete: {_ in})
    }
}
