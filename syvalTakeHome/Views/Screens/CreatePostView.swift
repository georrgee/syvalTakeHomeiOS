//  CreatePostView.swift
//  syvalTakeHome
//  Created by George Garcia on 6/2/25

import SwiftUI

struct CreatePostView: View {
    
    @Binding var isPresented: Bool
    @StateObject private var viewModel = CreatePostViewModel()
    
    var onPostCreated: (() -> Void)?

    
    var body: some View {
        NavigationView {
            ZStack {
                // Main content
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
                    .zIndex(999)
                    
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
                            
                            HStack(alignment: .center, spacing: 16) {
                                // Picture Button
                                Button(action: {}) {
                                    Image(systemName: "photo")
                                        .font(.title2)
                                        .foregroundColor(Color(hex: "5643F4"))
                                        .frame(width: 48, height: 48)
                                }
                                
                                Button(action: viewModel.toggleCategoryDropdown) {
                                    HStack {
                                        Text(viewModel.selectedCategory ?? "Category")
                                            .foregroundColor(viewModel.selectedCategory != nil ? .white : Color(hex: "5643F4"))
                                            .font(.system(size: 14, weight: .medium))
                                            .lineLimit(1)
                                            .truncationMode(.tail)
                                        Image(systemName: viewModel.showCategoryDropdown ? "chevron.up" : "chevron.down")
                                            .foregroundColor(viewModel.selectedCategory != nil ? .white : Color(hex: "5643F4"))
                                            .font(.system(size: 12))
                                    }
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 10)
                                    .frame(minWidth: 80, maxWidth: 140)
                                    .background(viewModel.selectedCategory != nil ? Color(hex: "5643F4") : Color.clear)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                }
                                .disabled(viewModel.selectedTransaction == nil)
                                .opacity(viewModel.selectedTransaction == nil ? 0.5 : 1.0)
                                
                                // Friends Button
                                FriendsButtonView(viewModel: viewModel)
                                
                                // Feeling Button
                                FeelingButtonView(viewModel: viewModel)
                                
                                Spacer()
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
                
                if viewModel.showCategoryDropdown {
                    Color.clear
                        .contentShape(Rectangle())
                        .onTapGesture {
                            viewModel.toggleCategoryDropdown()
                        }
                        .zIndex(1999)
                    
                    VStack(spacing: 0) {
                        Text("Select Category")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(UIColor.secondarySystemBackground))
                        
                        ScrollView {
                            LazyVStack(spacing: 0) {
                                ForEach(viewModel.categories, id: \.name) { category in
                                    Button(action: {
                                        withAnimation(.easeInOut(duration: 0.2)) {
                                            viewModel.selectCategory(category.name)
                                        }
                                    }) {
                                        HStack {
                                            Text(category.emoji)
                                                .font(.title3)
                                            Text(category.name)
                                                .font(.body)
                                                .foregroundColor(.primary)
                                            Spacer()
                                        }
                                        .padding(.vertical, 10)
                                        .padding(.horizontal, 16)
                                        .background(Color.clear)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                    
//                                    if category.name != viewModel.categories.last?.name {
//                                        Divider()
//                                            .padding(.horizontal, 16)
//                                    }
                                }
                            }
                        }
                        .frame(maxHeight: 400)
                    }
                    .background(Color(UIColor.systemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                    )
                    .frame(width: 280)
                    .position(x: UIScreen.main.bounds.width * 0.6, y: UIScreen.main.bounds.height * 0.4)
                    .transition(.asymmetric(
                        insertion: .scale(scale: 0.95, anchor: .top).combined(with: .opacity),
                        removal: .scale(scale: 0.95, anchor: .top).combined(with: .opacity)
                    ))
                    .zIndex(2000)
                }
                
                // Feeling Dropdown Overlay
                if viewModel.showFeelingDropdown {
                    Color.clear
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                viewModel.toggleFeelingDropdown()
                            }
                        }
                        .zIndex(1000)
                    
                    VStack(spacing: 0) {
                        Text("How do you feel about this?")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.primary)
                            .padding(10)
                            .frame(maxWidth: .infinity)
                            .background(Color(UIColor.secondarySystemBackground))
                        
                        ForEach(viewModel.feelings) { feeling in
                            Button(action: {
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    viewModel.selectFeeling(feeling.emoji)
                                }
                            }) {
                                HStack {
                                    Text(feeling.emoji)
                                        .font(.system(size: 22))
                                    
                                    Text(feeling.label)
                                        .font(.system(size: 15))
                                        .foregroundColor(.primary)
                                    
                                    Spacer()
                                }
                                .padding(.vertical, 12)
                                .padding(.horizontal, 16)
                                .background(Color.clear)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .shadow(color: Color.black.opacity(0.15), radius: 12, x: 0, y: 4)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                    )
                    .frame(width: 220)
                    .position(x: UIScreen.main.bounds.width * 0.6, y: UIScreen.main.bounds.height * 0.4)
                    .transition(.asymmetric(
                        insertion: .scale(scale: 0.95, anchor: .top).combined(with: .opacity),
                        removal: .scale(scale: 0.95, anchor: .top).combined(with: .opacity)
                    ))
                    .zIndex(1001)
                }
                
                // Friends Dropdown Overlay
                if viewModel.showFriendsDropdown {
                    Color.clear
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                viewModel.toggleFriendsDropdown()
                            }
                        }
                        .zIndex(1000)
                    
                    VStack(spacing: 0) {
                        HStack {
                            TextField("Search friends", text: $viewModel.friendSearchText)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .font(.system(size: 16))
                            
                            Button(action: {
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    viewModel.toggleFriendsDropdown()
                                }
                            }) {
                                Image(systemName: "xmark")
                                    .foregroundColor(.gray)
                                    .padding(8)
                            }
                        }
                        .padding()
                        .background(Color(UIColor.secondarySystemBackground))
                        
                        ScrollView {
                            LazyVStack(spacing: 0) {
                                if viewModel.filteredFriends.isEmpty && !viewModel.friendSearchText.isEmpty {
                                    VStack {
                                        Text("No friends found")
                                            .foregroundColor(.gray)
                                            .font(.system(size: 14))
                                            .padding(20)
                                    }
                                } else if viewModel.filteredFriends.isEmpty && viewModel.friendSearchText.isEmpty && viewModel.taggedFriends.count >= 5 {
                                    VStack {
                                        Text("All friends tagged")
                                            .foregroundColor(.gray)
                                            .font(.system(size: 14))
                                            .padding(20)
                                    }
                                } else {
                                    ForEach(viewModel.filteredFriends) { friend in
                                        Button(action: {
                                            withAnimation(.easeInOut(duration: 0.2)) {
                                                viewModel.tagFriend(friend)
                                            }
                                        }) {
                                            HStack {
                                                Circle()
                                                    .fill(Color(hex: "5643F4"))
                                                    .frame(width: 32, height: 32)
                                                    .overlay(
                                                        Text(String(friend.name.prefix(1)).uppercased())
                                                            .font(.system(size: 14, weight: .bold))
                                                            .foregroundColor(.white)
                                                    )
                                                
                                                Text(friend.name)
                                                    .foregroundColor(.primary)
                                                    .font(.system(size: 16))
                                                
                                                Spacer()
                                            }
                                            .padding(.vertical, 12)
                                            .padding(.horizontal, 16)
                                            .background(Color.clear)
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                    }
                                } 
                            }
                        }
                        .frame(maxHeight: 200)
                        
                        if viewModel.taggedFriends.count >= 5 {
                            HStack {
                                Text("Maximum 5 friends can be tagged")
                                    .font(.system(size: 12))
                                    .foregroundColor(Color(hex: "856404"))
                                    .padding(8)
                            }
                            .frame(maxWidth: .infinity)
                            .background(Color(hex: "fff3cd"))
                            .overlay(
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(Color(hex: "ffeaa7")),
                                alignment: .top
                            )
                        }
                    }
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .shadow(color: Color.black.opacity(0.15), radius: 12, x: 0, y: 4)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                    )
                    .frame(width: 280)
                    .position(x: UIScreen.main.bounds.width * 0.5, y: UIScreen.main.bounds.height * 0.45)
                    .transition(.asymmetric(
                        insertion: .scale(scale: 0.95, anchor: .top).combined(with: .opacity),
                        removal: .scale(scale: 0.95, anchor: .top).combined(with: .opacity)
                    ))
                    .zIndex(1001)
                }
            }
            .animation(.spring(response: 0.3, dampingFraction: 0.7), value: viewModel.showCategoryDropdown)
            .animation(.spring(response: 0.3, dampingFraction: 0.7), value: viewModel.showFeelingDropdown)
            .animation(.spring(response: 0.3, dampingFraction: 0.7), value: viewModel.showFriendsDropdown)
            .onTapGesture {
                viewModel.closeAllDropdowns()
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            viewModel.onPostCreated = onPostCreated
        }
    }
}

#Preview {
    CreatePostView(isPresented: .constant(true))
}
