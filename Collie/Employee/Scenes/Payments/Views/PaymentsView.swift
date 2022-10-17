import SwiftUI

struct PaymentsView: View {
    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: true) {
                VStack {
                    HStack {
                        Text("Pagamentos")
                            .font(.system(size: 40, weight: .bold, design: .default))
                            .foregroundColor(Color.black)
                        
                        Spacer()
                    }
                    
                    Spacer()
                }
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 32)
        .frame(maxWidth: .infinity)
        .frame(maxHeight: .infinity)
        .background(Color.collieBrancoFundo.ignoresSafeArea())
        .navigationTitle("Pagamentos")
    }
}

struct PaymentsView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentsView()
    }
}
