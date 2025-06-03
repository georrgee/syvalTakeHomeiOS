//  CreatePostView.swift
//  syvalTakeHome
//  Created by George Garcia on 6/2/25

import SwiftUI

struct PostView: View {
    
    let post: Post
    @State private var isExpanded = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top, spacing: 12) {
                // Setting up da profile picture
                ProfilePictureView(name: post.name)
                
                VStack(alignment: .leading, spacing: 4) {
                    // Header
                    PostHeaderView(post: post)
                    
                    // Timestamp and Style
                    Text("\(post.timestamp) • \(post.spendingStyle ?? "")")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                    
                    // Title
                    if let title = post.title {
                        Text(title)
                            .font(.system(size: 18, weight: .bold))
                            .padding(.top, 4)
                    }
                    
                    // Caption
                    if let caption = post.caption {
                        CaptionView(caption: caption, isExpanded: $isExpanded)
                    }
                    
                    // Tagged Friends
                    if let taggedFriends = post.taggedFriends, !taggedFriends.isEmpty {
                        TaggedFriendsView(friends: taggedFriends)
                    }
                    
                    // Images
                    if post.image != nil {
                        PostImagesView()
                    }
                    
                    // Interactions
                    InteractionsView(likes: post.likes ?? 0, comments: post.comments ?? 0)
                    
                    // Transaction Badge
                    TransactionBadge(transaction: post.transaction)
                        .padding(.top, 8)
                }
            }
            .padding(16)
        }
        .background(getBackgroundColor(for: post.category))
        .clipShape(RoundedRectangle(cornerRadius: 0))
        .padding(.horizontal, 0)
    }
    
    // MARK: - Helper Views
    
    private func ProfilePictureView(name: String) -> some View {
        Circle()
            .fill(Color.gray.opacity(0.3))
            .frame(width: 40, height: 40)
            .overlay(
                Text(getProfileInitials(name))
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.gray)
            )
    }
    
    private func PostHeaderView(post: Post) -> some View {
        HStack {
            HStack(spacing: 8) {
                Text(post.name)
                    .font(.system(size: 16, weight: .bold))
                Text(post.amount)
                    .font(.system(size: 16, weight: .bold))
                Text(post.category ?? "")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .italic()
            }
            
            Spacer()
            
            Button(action: {}) {
                Image(systemName: "ellipsis")
                    .foregroundColor(.gray)
            }
        }
    }
    
    private func CaptionView(caption: String, isExpanded: Binding<Bool>) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(isExpanded.wrappedValue ? caption : getTruncatedCaption(caption))
                .font(.system(size: 14))
                .foregroundColor(.primary)
            
            if caption.contains("\n") {
                Button(action: { isExpanded.wrappedValue.toggle() }) {
                    Text(isExpanded.wrappedValue ? "Read Less" : "Read More")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(Color(hex: "6A5ACD"))
                }
            }
        }
        .padding(.top, 4)
    }
    
    private func TaggedFriendsView(friends: [Friend]) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("With:")
                .font(.system(size: 12))
                .foregroundColor(.gray)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 6) {
                    ForEach(friends) { friend in
                        FriendTagView(friend: friend)
                    }
                }
            }
        }
        .padding(.top, 8)
    }
    
    private func FriendTagView(friend: Friend) -> some View {
        HStack(spacing: 4) {
            Image(systemName: "at")
                .font(.system(size: 10))
            Text(friend.name)
                .font(.system(size: 12))
        }
        .foregroundColor(Color(hex: "5643F4"))
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(Color.gray.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
    
    private func PostImagesView() -> some View {
        HStack(spacing: 8) {
            PostImageView(url: "https://via.placeholder.com/150x100/FF6B6B/FFFFFF?text=Food+1")
            PostImageView(url: "https://via.placeholder.com/150x100/4ECDC4/FFFFFF?text=Food+2")
        }
        .padding(.top, 8)
    }
    
    private func PostImageView(url: String) -> some View {
        AsyncImage(url: URL(string: url)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
        } placeholder: {
            Rectangle()
                .fill(Color.gray.opacity(0.3))
        }
        .frame(width: 100, height: 80)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
    
    private func InteractionsView(likes: Int, comments: Int) -> some View {
        HStack(spacing: 16) {
            InteractionButton(icon: "hand.thumbsup", text: "\(likes)") {}
            InteractionButton(icon: "bubble.left", text: "\(comments) comments") {}
            Spacer()
        }
        .padding(.top, 8)
    }
    
    private func InteractionButton(icon: String, text: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack(spacing: 4) {
                Image(systemName: icon)
                Text(text)
            }
            .font(.system(size: 12))
            .foregroundColor(.gray)
        }
    }
    
    private func TransactionBadge(transaction: String) -> some View {
        HStack(spacing: 4) {
            Image(systemName: "creditcard")
                .font(.system(size: 12))
            Text(transaction)
                .font(.system(size: 12))
        }
        .foregroundColor(.gray)
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(Color.gray.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
    
    // MARK: - Helper Methods
    
    private func getProfileInitials(_ name: String) -> String {
        name.split(separator: " ").map { String($0.prefix(1)) }.joined().uppercased()
    }
    
    private func getTruncatedCaption(_ caption: String) -> String {
        let lines = caption.components(separatedBy: "\n")
        return lines.first ?? "" + (lines.count > 1 ? "..." : "")
    }
    
    private func getBackgroundColor(for category: String?) -> Color {
        guard let category = category else { return Color.clear }
        
        if let hashtag = MockDataService.shared.mockHashtags.first(where: { $0.name == category }) {
            return Color(hex: hashtag.color)
        }
        
        return Color.clear
    }
}

#Preview {
    PostView(post: MockDataService.shared.postsData[0])
}
