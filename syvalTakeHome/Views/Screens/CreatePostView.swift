//  CreatePostView.swift
//  syvalTakeHome
//  Created by George Garcia on 6/2/25

import SwiftUI

struct CreatePostView: View {
    
    @Binding var isPresented: Bool
    @StateObject private var viewModel = CreatePostViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Header
                HStack {
                    Button("Cancel") {
                        isPresented = false
                    }
                    
                    Spacer()
                    
                    Text("Create a post")
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Button("Post") {
                        viewModel.createPost()
                        isPresented = false
                    }
                    .disabled(!viewModel.canPost)
                    .foregroundColor(viewModel.canPost ? .white : .gray)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(viewModel.canPost ? Color(hex: "5643F4") : Color.gray.opacity(0.3))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                .padding()
                .background(Color(UIColor.systemBackground))
                .overlay(
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color.gray.opacity(0.3)),
                    alignment: .bottom
                )
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        // Title and Text Input
                        VStack(alignment: .leading, spacing: 8) {
                            TextField("Title (optional)", text: $viewModel.postTitle)
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            TextField("Share your journey (optional)", text: $viewModel.postText, axis: .vertical)
                                .font(.body)
                                .lineLimit(5...10)
                        }
                        .padding()
                        
                        // Action Buttons
                        HStack(spacing: 20) {
                            // Picture Button
                            Button(action: {}) {
                                Image(systemName: "photo")
                                    .font(.title2)
                                    .foregroundColor(Color(hex: "5643F4"))
                                    .frame(width: 48, height: 48)
                            }
                            
                            // Category Button
                            CategoryButtonView(viewModel: viewModel)
                            
                            // Friends Button
                            FriendsButtonView(viewModel: viewModel)
                            
                            // Feeling Button
                            FeelingButtonView(viewModel: viewModel)
                        }
                        .padding(.horizontal)
                        
                        // Tagged Friends
                        if !viewModel.taggedFriends.isEmpty {
                            TaggedFriendsView(viewModel: viewModel)
                        }
                        
                        // Hashtags
                        HashtagSectionView(viewModel: viewModel)
                        
                        // Transactions
                        TransactionSectionView(viewModel: viewModel)
                    }
                }
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    CreatePostView(isPresented: .constant(true))
}
