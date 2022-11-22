import SwiftUI

struct UserSelectionDropdown: View {
    @Binding var showList: Bool
    var label: String
    var allUsers: [UserModel]
    var selectedUsers: [UserModel]
    var allUsersScrollHeight: CGFloat
    var selectedUsersScrollHeight: CGFloat
    var handleUserSelection: (UserModel) -> ()
    var handleUserRemove: (UserModel) -> ()
    
    @State var showLoadingIndicator = true
    
    var body: some View {
        VStack {
            VStack {
                ScrollView(.vertical) {
                    VStack(spacing: 0) {
                        Button {
                            withAnimation {
                                showList.toggle()
                            }
                        } label: {
                            VStack(spacing: 0) {
                                HStack {
                                    Text(label)
                                        .padding(.vertical)
                                    Spacer()
                                    if showLoadingIndicator {
                                        LoadingIndicator()
                                            .frame(width: 24, height: 24)
                                    } else {
                                        Image(systemName: "chevron.down")
                                    }
                                }
                                .collieFont(textStyle: .regularText)
                            }
                            .frame(height: 40)
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal)
                            .contentShape(Rectangle())
                        }
                        .buttonStyle(.plain)
                        
                        Divider()
                            .frame(height: 1)
                            .padding(.horizontal)
                        
                        if showList {
                            ForEach(allUsers) { user in
                                UserCellView(user: user) {
                                    handleUserSelection(user)
                                }
                            }
                        }
                    }
                }
                .frame(maxHeight: allUsersScrollHeight)
            }
            .background(Color.white)
            .foregroundColor(.black)
            .cornerRadius(8)
            
            if !selectedUsers.isEmpty {
                ScrollView(.vertical, showsIndicators: true) {
                    VStack(spacing: 0) {
                        ForEach(selectedUsers.reversed()) { user in
                            ChosenUserCellView(user: user) {
                                handleUserRemove(user)
                            }
                        }
                    }
                }
                .frame(maxHeight: selectedUsersScrollHeight)
                .background(Color.white.opacity(0.5))
                .cornerRadius(8)
            }
        }
    }
}
