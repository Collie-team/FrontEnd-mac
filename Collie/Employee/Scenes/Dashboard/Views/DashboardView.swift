import SwiftUI

struct DashboardView: View {
    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: true) {
                VStack {
                    HStack {
                        Text("Dashboard")
                            .collieFont(textStyle: .title)
                            .foregroundColor(Color.black)
                        
                        Spacer()
                    }
                    
                    Spacer()
                }
            }
        }
        .padding(.horizontal, 32)
        .padding(.top, 32)
        .padding(.bottom)
        .frame(maxWidth: .infinity)
        .frame(maxHeight: .infinity)
        .background(Color.collieBrancoFundo.ignoresSafeArea())
        .navigationTitle("Dashboard")
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
