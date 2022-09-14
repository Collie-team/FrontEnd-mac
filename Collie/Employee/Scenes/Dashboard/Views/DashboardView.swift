import SwiftUI

struct DashboardView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("Dashboard")
                .padding()
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .frame(maxHeight: .infinity)
        .navigationTitle("Dashboard")
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
