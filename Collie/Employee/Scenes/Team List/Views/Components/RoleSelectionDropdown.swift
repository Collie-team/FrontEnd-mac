import SwiftUI

struct RoleSelectionDropdown: View {
    @State var showList = false
    @Binding var selectedRole: BusinessUserRoles
    
    var body: some View {
        VStack(spacing: 0) {
            Button(action: {
                withAnimation {
                    showList.toggle()
                }
            }) {
                VStack(spacing: 0) {
                    HStack {
                        Text(selectedRole.getRoleText())
                            .padding(.vertical)
                        Spacer()
                        Image(systemName: showList ? "chevron.up" : "chevron.down")
                    }
                    .collieFont(textStyle: .regularText)
                }
                .foregroundColor(Color.collieCinzaEscuro)
                .frame(height: 40)
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
                .background(Color.collieTextFieldBackground)
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            
            if showList {
                VStack(spacing: 12) {
                    
                    Divider()
                        .frame(height: 1)
                        .background(Color.collieCinzaBorda)
                        .padding(.horizontal)
                    
                    ForEach(BusinessUserRoles.allCases, id:\.self) { role in
                        VStack() {
                            HStack {
                                Text(role.getRoleText())
                                Spacer()
                            }
                            
                            Divider()
                                .frame(height: 1)
                                .background(Color.collieCinzaBorda)
                        }
                        .collieFont(textStyle: .regularText)
                        .foregroundColor(Color.collieCinzaEscuro)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation {
                                selectedRole = role
                                showList.toggle()
                            }
                        }
                    }
                }
            }
        }
        .background(Color.collieTextFieldBackground)
        .foregroundColor(Color.collieCinzaEscuro)
        .cornerRadius(8)
        .modifier(CustomBorder())
    }
}

struct RoleSelectionDropdown_Previews: PreviewProvider {
    static var previews: some View {
        RoleSelectionDropdown(selectedRole: .constant(.employee))
            .padding()
            .frame(height: 500)
            .background(Color.white)
    }
}
