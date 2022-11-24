import SwiftUI

struct BusinessDisplayFormView: View {
    @Binding var rootViewModelSelectedBusiness: Business
    @State var currentBusiness: Business
    @Binding var editingMode: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                Button(action: {
                    withAnimation {
                        editingMode = true
                    }
                }) {
                    Text("Editar \(Image(systemName: "square.and.pencil"))")
                        .foregroundColor(Color.collieRoxo)
                        .collieFont(textStyle: .subtitle)
                }
                .buttonStyle(.plain)
                .contentShape(Rectangle())
            }
            VStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Nome do workspace")
                        .collieFont(textStyle: .regularText)
                    HStack {
                        Text(currentBusiness.name)
                            .collieFont(textStyle: .smallTitle)
                        Spacer()
                    }
                }
            }
            .frame(maxWidth: 600)
        }
        .onChange(of: rootViewModelSelectedBusiness) { updatedBusiness in
            currentBusiness = updatedBusiness
        }
    }
}

//struct BusinessDisplayFormView_Previews: PreviewProvider {
//    static var previews: some View {
//        BusinessDisplayFormView(editingMode: .constant(true))
//            .environmentObject(RootViewModel())
//    }
//}
