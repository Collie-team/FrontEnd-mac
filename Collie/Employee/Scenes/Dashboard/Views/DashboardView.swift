import SwiftUI

struct DashboardView: View {
    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: true) {
                VStack {
                    HStack {
                        Text("Dashboard")
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
        .background(Color.collieBranco.ignoresSafeArea())
        .navigationTitle("Dashboard")
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
