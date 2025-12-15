//
//  InvitePeopleView.swift
//  DinnerParty
//
//  Created by Seyedreza Aghayarikordkandi on 15/12/25.
//



//
//  InvitePeopleView.swift
//  DinnerParty
//
//  Created by Seyedreza Aghayarikordkandi on 12/12/25.
//

import SwiftUI

struct InvitePeopleView: View {
    
    @State private var friendName: String = ""
    @State private var friends: [String] = []
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                
                // MARK: Title
                Text("Invite People")
                    .font(.system(size: 28, weight: .bold))
                    .padding(.top, 10)
                
                // MARK: TextField + Add Button
                HStack {
                    TextField("Enter friend's name", text: $friendName)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(16)
                    
                    Button {
                        addFriend()
                    } label: {
                        Image(systemName: "plus")
                            .font(.system(size: 20, weight: .bold))
                            .padding()
                            .background(Color("AmberGlow"))
                            .foregroundColor(.white)
                            .clipShape(Circle())
                    }
                }
                .padding(.horizontal, 24)
                
                // MARK: Friends List
                if friends.isEmpty {
                    Text("No friends added yet.")
                        .foregroundColor(.gray)
                } else {
                    List {
                        ForEach(friends, id: \.self) { friend in
                            HStack {
                                Text(friend)
                                    .font(.system(size: 18, weight: .medium))
                                    .padding(.vertical, 5)
                                
                                Spacer()
                                
                                Image(systemName: "person.crop.circle.fill.badge.checkmark")
                                    .foregroundColor(Color("AmberGlow"))
                            }
                        }
                        .onDelete(perform: deleteFriend)
                    }
                    .frame(maxHeight: 300)
                }
                
                Spacer()
                
                // MARK: Send Invite Button
                Button {
                    // future: connect to CloudKit / backend
                } label: {
                    Text("Send Invites")
                        .font(.system(size: 18, weight: .semibold))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(friends.isEmpty ? Color.gray.opacity(0.3) : Color("MutedTeal"))
                        .foregroundColor(.white)
                        .cornerRadius(20)
                }
                .padding(.horizontal, 24)
                .disabled(friends.isEmpty)
                
                Spacer()
            }
            .navigationTitle("Invite Guests")
        }
    }
    
    // MARK: Functions
    private func addFriend() {
        let trimmed = friendName.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty else { return }
        
        friends.append(trimmed)
        friendName = ""
    }
    
    private func deleteFriend(at offsets: IndexSet) {
        friends.remove(atOffsets: offsets)
    }
}

#Preview {
    InvitePeopleView()
}
