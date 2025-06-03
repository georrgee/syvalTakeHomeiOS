//  CreatePostView.swift
//  syvalTakeHome
//  Created by George Garcia on 6/2/25

import SwiftUI

// MARK: - Helper Views
struct HeaderView: View {
    @Binding var isPresented: Bool
    @ObservedObject var viewModel: CreatePostViewModel
    
    var body: some View {
        HStack {
            Button("Cancel") {
                isPresented = false
            }
            
            Spacer()
            
            Text("Share your journey")
                .font(.headline)
                .fontWeight(.semibold)
            
            Spacer()
            
            let postButtonColor = viewModel.canPost ? Color(.white) : Color(.gray)
            let postButtonBackground = viewModel.canPost ? Color(hex: "5643F4") : Color.gray.opacity(0.3)

            Button("Post") {
                viewModel.createPost()
                isPresented = false
            }
            .disabled(!viewModel.canPost)
            .foregroundColor(postButtonColor)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(postButtonBackground)
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
    }
}

struct InputFieldsView: View {
    @ObservedObject var viewModel: CreatePostViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            TextField("Title (optional)", text: $viewModel.postTitle)
                .font(.title2)
                .fontWeight(.bold)
            
            TextField("Write your thoughts (optional)", text: $viewModel.postText, axis: .vertical)
                .font(.body)
                .lineLimit(5...10)
        }
        .padding()
    }
}

struct ActionButtonsView: View {
    @ObservedObject var viewModel: CreatePostViewModel
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            // Picture Button
            Button(action: {}) {
                Image(systemName: "photo")
                    .font(.title2)
                    .foregroundColor(Color(hex: "5643F4"))
                    .frame(width: 30, height: 30)
            }
            
            CategoryButtonView(viewModel: viewModel)
            
            // Friends Button
            FriendsButtonView(viewModel: viewModel)
            
            // Feeling Button
            FeelingButtonView(viewModel: viewModel)
            
            // Goal Button
            GoalButtonView(viewModel: viewModel)
            
            Spacer()
        }
        .padding(.horizontal)
    }
}


struct GoalDropdownView: View {
    @ObservedObject var viewModel: CreatePostViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Link to Financial Goal")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.primary)
                .padding(10)
                .frame(maxWidth: .infinity)
                .background(Color(UIColor.secondarySystemBackground))
            
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(viewModel.goals) { goal in
                        GoalItemView(goal: goal, viewModel: viewModel)
                    }
                }
            }
            .frame(maxHeight: 200)
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: Color.black.opacity(0.15), radius: 12, x: 0, y: 4)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
        )
        .frame(width: 250)
        .position(x: UIScreen.main.bounds.width * 0.6, y: UIScreen.main.bounds.height * 0.4)
    }
}

struct GoalItemView: View {
    let goal: Goal
    @ObservedObject var viewModel: CreatePostViewModel
    
    var body: some View {
        Button(action: {
            withAnimation(.easeInOut(duration: 0.2)) {
                viewModel.selectGoal(goal)
            }
        }) {
            HStack {
                Circle()
                    .fill(Color(hex: goal.color))
                    .frame(width: 12, height: 12)
                
                Text(goal.name)
                    .font(.system(size: 15))
                    .foregroundColor(.primary)
                
                Spacer()
                
                // Show progress
                Text("\(Int(goal.progressPercentage))%")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(viewModel.selectedGoal?.id == goal.id ? Color.gray.opacity(0.1) : Color.clear)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct DropdownBackdropView: View {
    var onTap: () -> Void
    
    var body: some View {
        Color.clear
            .contentShape(Rectangle())
            .onTapGesture(perform: onTap)
            .zIndex(999)
    }
}

struct CategoryDropdownView: View {
    @ObservedObject var viewModel: CreatePostViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Select Category")
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(UIColor.secondarySystemBackground))
            
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(viewModel.categories, id: \.name) { category in
                        CategoryItemView(category: category, viewModel: viewModel)
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
        .zIndex(2000)
    }
}

struct CategoryItemView: View {
    let category: Category
    @ObservedObject var viewModel: CreatePostViewModel
    
    var body: some View {
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
    }
}

struct FeelingDropdownView: View {
    @ObservedObject var viewModel: CreatePostViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            Text("How do you feel about this?")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.primary)
                .padding(10)
                .frame(maxWidth: .infinity)
                .background(Color(UIColor.secondarySystemBackground))
            
            ForEach(viewModel.feelings) { feeling in
                FeelingItemView(feeling: feeling, viewModel: viewModel)
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
    }
}

struct FeelingItemView: View {
    let feeling: Feeling
    @ObservedObject var viewModel: CreatePostViewModel
    
    var body: some View {
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

struct FriendsDropdownView: View {
    @ObservedObject var viewModel: CreatePostViewModel
    
    var body: some View {
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
                    FriendListView(viewModel: viewModel)
                }
            }
            .frame(maxHeight: 200)
            
            if viewModel.taggedFriends.count >= 5 {
                MaxFriendsWarningView()
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
    }
}

struct MaxFriendsWarningView: View {
    var body: some View {
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

struct FriendListView: View {
    @ObservedObject var viewModel: CreatePostViewModel
    
    var body: some View {
        if viewModel.filteredFriends.isEmpty && !viewModel.friendSearchText.isEmpty {
            EmptyFriendsView(message: "No friends found")
        } else if viewModel.filteredFriends.isEmpty && viewModel.friendSearchText.isEmpty && viewModel.taggedFriends.count >= 5 {
            EmptyFriendsView(message: "All friends tagged")
        } else {
            ForEach(viewModel.filteredFriends) { friend in
                FriendItemView(friend: friend, viewModel: viewModel)
            }
        }
    }
}

struct EmptyFriendsView: View {
    let message: String
    
    var body: some View {
        VStack {
            Text(message)
                .foregroundColor(.gray)
                .font(.system(size: 14))
                .padding(20)
        }
    }
}

struct FriendItemView: View {
    let friend: Friend
    @ObservedObject var viewModel: CreatePostViewModel
    
    var body: some View {
        Button(action: {
            withAnimation(.easeInOut(duration: 0.2)) {
                viewModel.tagFriend(friend)
            }
        }) {
            HStack {
                Circle()
                    .fill(Color (hex: "5643F4"))
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

struct MainContentView: View {
    @Binding var isPresented: Bool
    @ObservedObject var viewModel: CreatePostViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            HeaderView(isPresented: $isPresented, viewModel: viewModel)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    InputFieldsView(viewModel: viewModel)
                    
                    // Modified action buttons without goal
                    HStack(alignment: .center, spacing: 16) {
                        // Picture Button
                        Button(action: {}) {
                            Image(systemName: "photo")
                                .font(.title2)
                                .foregroundColor(Color(hex: "5643F4"))
                                .frame(width: 48, height: 48)
                        }
                        
                        CategoryButtonView(viewModel: viewModel)
                        
                        // Friends Button
                        FriendsButtonView(viewModel: viewModel)
                        
                        // Feeling Button
                        FeelingButtonView(viewModel: viewModel)
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    // New dedicated goal section
                    if viewModel.selectedGoal == nil {
                        Button(action: viewModel.toggleGoalDropdown) {
                            HStack {
                                Image(systemName: "target")
                                    .font(.system(size: 16))
                                Text("Personal goals")
                                    .font(.system(size: 15, weight: .medium))
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 14))
                            }
                            .foregroundColor(Color(hex: "5643F4"))
                            .padding()
                            .background(Color.gray.opacity(0.05))
                            .cornerRadius(12)
                        }
                        .padding(.horizontal)
                    } else {
                        // Show selected goal with more details
                        GoalSelectionView(viewModel: viewModel)
                            .padding(.horizontal)
                    }
                    
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
}

struct GoalSelectionView: View {
    @ObservedObject var viewModel: CreatePostViewModel
    
    var body: some View {
        if let goal = viewModel.selectedGoal {
            HStack(spacing: 12) {
                Circle()
                    .fill(Color(hex: goal.color))
                    .frame(width: 24, height: 24)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(goal.name)
                        .font(.system(size: 16, weight: .medium))
                    
                    // Progress bar
                    GeometryReader { geometry in
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .fill(Color.gray.opacity(0.2))
                                .frame(height: 6)
                                .cornerRadius(3)
                            
                            Rectangle()
                                .fill(Color(hex: goal.color))
                                .frame(width: geometry.size.width * goal.progressPercentage / 100, height: 6)
                                .cornerRadius(3)
                        }
                    }
                    .frame(height: 6)
                    
                    Text("\(Int(goal.progressPercentage))% complete")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                Button(action: {
                    viewModel.selectedGoal = nil
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
            .padding()
            .background(Color.gray.opacity(0.05))
            .cornerRadius(12)
        }
    }
}

//struct MainContentView: View {
//    @Binding var isPresented: Bool
//    @ObservedObject var viewModel: CreatePostViewModel
//    
//    var body: some View {
//        VStack(spacing: 0) {
//            HeaderView(isPresented: $isPresented, viewModel: viewModel)
//            
//            ScrollView {
//                VStack(alignment: .leading, spacing: 16) {
//                    InputFieldsView(viewModel: viewModel)
//                    ActionButtonsView(viewModel: viewModel)
//                    
//                    // Tagged Friends
//                    if !viewModel.taggedFriends.isEmpty {
//                        TaggedFriendsView(viewModel: viewModel)
//                    }
//                    
//                    // Hashtags
//                    HashtagSectionView(viewModel: viewModel)
//                    
//                    // Transactions
//                    TransactionSectionView(viewModel: viewModel)
//                }
//            }
//        }
//    }
//}

// MARK: - Main View

struct CreatePostView: View {
    @Binding var isPresented: Bool
    @StateObject private var viewModel = CreatePostViewModel()
    
    var onPostCreated: (() -> Void)?
    
    var body: some View {
        NavigationView {
            ZStack {
                // Main content
                MainContentView(isPresented: $isPresented, viewModel: viewModel)
                
                // Dropdowns
                if viewModel.showCategoryDropdown {
                    DropdownBackdropView { viewModel.toggleCategoryDropdown() }
                    CategoryDropdownView(viewModel: viewModel)
                        .transition(.asymmetric(
                            insertion: .scale(scale: 0.95, anchor: .top).combined(with: .opacity),
                            removal: .scale(scale: 0.95, anchor: .top).combined(with: .opacity)
                        ))
                }
                
                if viewModel.showFeelingDropdown {
                    DropdownBackdropView { viewModel.toggleFeelingDropdown() }
                    FeelingDropdownView(viewModel: viewModel)
                        .transition(.asymmetric(
                            insertion: .scale(scale: 0.95, anchor: .top).combined(with: .opacity),
                            removal: .scale(scale: 0.95, anchor: .top).combined(with: .opacity)
                        ))
                        .zIndex(1001)
                }
                
                if viewModel.showFriendsDropdown {
                    DropdownBackdropView { viewModel.toggleFriendsDropdown() }
                    FriendsDropdownView(viewModel: viewModel)
                        .transition(.asymmetric(
                            insertion: .scale(scale: 0.95, anchor: .top).combined(with: .opacity),
                            removal: .scale(scale: 0.95, anchor: .top).combined(with: .opacity)
                        ))
                        .zIndex(1001)
                }
                
                if viewModel.showGoalDropdown {
                    DropdownBackdropView { viewModel.toggleGoalDropdown() }
                    GoalDropdownView(viewModel: viewModel)
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
            .animation(.spring(response: 0.3, dampingFraction: 0.7), value: viewModel.showGoalDropdown)
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

// MARK: - Preview

#Preview {
    CreatePostView(isPresented: .constant(true))
}
