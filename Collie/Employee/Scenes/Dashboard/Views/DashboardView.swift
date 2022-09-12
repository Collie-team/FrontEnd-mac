import SwiftUI

struct DashboardView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("Hello, world!")
                .padding()
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .frame(maxHeight: .infinity)
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
