//  TaggedFriendsView.swift
//  syvalTakeHome
//  Created by George Garcia on 6/2/25

import SwiftUI

struct FriendTagView: View {
    let friend: Friend
    let onRemove: () -> Void
    
    var body: some View {
        HStack(spacing: 6) {
            Text("@\(friend.name)")
                .font(.system(size: 14))
                .foregroundColor(Color(hex: "5643F4"))
            
            Button(action: onRemove) {
                Image(systemName: "xmark")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(Color.gray.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

struct TaggedFriendsView: View {
    
    @ObservedObject var viewModel: CreatePostViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Tagged Friends:")
                .font(.system(size: 14))
                .foregroundColor(.gray)
                .padding(.horizontal, 20)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(viewModel.taggedFriends) { friend in
                        FriendTagView(
                            friend: friend,
                            onRemove: { viewModel.removeFriend(friend.id) }
                        )
                    }
                }
                .padding(.horizontal, 20)
            }
        }
        .padding(.vertical, 10)
    }
}

#Preview {
    let viewModel = CreatePostViewModel()
    viewModel.taggedFriends = [
        Friend(id: "1", name: "Haruka"),
        Friend(id: "2", name: "Rey Delgado")
    ]
    return TaggedFriendsView(viewModel: viewModel)
}
