import SwiftUI

struct BusinessEditingFormView: View {
    @EnvironmentObject var rootViewModel: RootViewModel
    @Binding var editingMode: Bool
    @State var businessName: String = ""
    
    var handleBusinessNameSave: (String) -> ()
    
    init(editingMode: Binding<Bool>, businessName: String, handleBusinessNameSave: @escaping (String) -> ()) {
        self._editingMode = editingMode
        self.businessName = businessName
        self.handleBusinessNameSave = handleBusinessNameSave
    }
    
    var body: some View {
        VStack {
            VStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Nome do workspace")
                        .collieFont(textStyle: .regularText)
                    CustomTextField("Nome", text: $businessName)
                }
                
                Divider()
                
                HStack(spacing: 16) {
                    SimpleButton(label: "Reverter alterações") {
                        withAnimation {
                            editingMode = false
                        }
                    }
                    
                    SimpleButton(label: "Salvar alterações") {
                        withAnimation {
                            handleBusinessNameSave(businessName)
                            editingMode = false
                        }
                    }
        
                    Spacer()
                }
            }
            .frame(maxWidth: 600)
        }
    }
}

//struct BusinessEditingFormView_Previews: PreviewProvider {
//    static var previews: some View {
//        BusinessEditingFormView(editingMode: .constant(true), currentBusiness: Business(name: "Aurea", description: "", journeys: [], tasks: [], categories: [], events: []))
//            .environmentObject(RootViewModel())
//            .frame(width: 800, height: 600)
//    }
//}
