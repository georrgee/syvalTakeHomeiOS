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
                Circle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 40, height: 40)
                    .overlay(
                        Text(getProfileInitials(post.name))
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.gray)
                    )
                
                VStack(alignment: .leading, spacing: 4) {
                    // Header
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
                        VStack(alignment: .leading, spacing: 4) {
                            Text(isExpanded ? caption : getTruncatedCaption(caption))
                                .font(.system(size: 14))
                                .foregroundColor(.primary)
                            
                            if caption.contains("\n") {
                                Button(action: { isExpanded.toggle() }) {
                                    Text(isExpanded ? "Read Less" : "Read More")
                                        .font(.system(size: 14, weight: .bold))
                                        .foregroundColor(Color(hex: "6A5ACD"))
                                }
                            }
                        }
                        .padding(.top, 4)
                    }
                    
                    // Images
                    if post.image != nil {
                        HStack(spacing: 8) {
                            AsyncImage(url: URL(string: "https://via.placeholder.com/150x100/FF6B6B/FFFFFF?text=Food+1")) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            } placeholder: {
                                Rectangle()
                                    .fill(Color.gray.opacity(0.3))
                            }
                            .frame(width: 100, height: 80)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            
                            AsyncImage(url: URL(string: "https://via.placeholder.com/150x100/4ECDC4/FFFFFF?text=Food+2")) { image in
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
                        .padding(.top, 8)
                    }
                    
                    // Interactions
                    HStack(spacing: 16) {
                        Button(action: {}) {
                            HStack(spacing: 4) {
                                Image(systemName: "hand.thumbsup")
                                Text("\(post.likes ?? 0)")
                            }
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                        }
                        
                        Button(action: {}) {
                            HStack(spacing: 4) {
                                Image(systemName: "bubble.left")
                                Text("\(post.comments ?? 0) comments")
                            }
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                        }
                        
                        Spacer()
                    }
                    .padding(.top, 8)
                    
                    // Transaction Badge
                    HStack(spacing: 4) {
                        Image(systemName: "creditcard")
                            .font(.system(size: 12))
                        Text(post.transaction)
                            .font(.system(size: 12))
                    }
                    .foregroundColor(.gray)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.gray.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.top, 8)
                }
            }
            .padding(16)
        }
        .background(getBackgroundColor(for: post.category))
        .clipShape(RoundedRectangle(cornerRadius: 0))
        .padding(.horizontal, 16)
    }
    
    private func getProfileInitials(_ name: String) -> String {
        name.split(separator: " ").map { String($0.prefix(1)) }.joined().uppercased()
    }
    
    private func getTruncatedCaption(_ caption: String) -> String {
        let lines = caption.components(separatedBy: "\n")
        return lines.first ?? "" + (lines.count > 1 ? "..." : "")
    }
    
    private func getBackgroundColor(for category: String?) -> Color {
        switch category {
        case "#reflect":
            return Color(hex: "E3D1A1")
        case "#flex":
            return Color(hex: "C4B9FE")
        default:
            return Color.clear
        }
    }
}

#Preview {
    PostView(post: MockDataService.shared.postsData[0])
}

