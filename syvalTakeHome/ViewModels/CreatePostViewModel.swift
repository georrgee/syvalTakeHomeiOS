//  CreatePostViewModel.swift
//  syvalTakeHome
//  Created by George Garcia on 6/2/25.

import Foundation
import SwiftUI

class CreatePostViewModel: ObservableObject {
    
    @Published var postTitle               = ""
    @Published var postText                = ""
    @Published var showCategoryDropdown    = false
    @Published var taggedFriends: [Friend] = []
    @Published var showFriendsDropdown     = false
    @Published var friendSearchText        = ""
    @Published var showFeelingDropdown     = false
    
    @Published var selectedTransaction: Transaction?
    @Published var selectedHashtag:     String?
    @Published var selectedCategory:    String?
    @Published var selectedFeeling:     String?
    
    private let dataService = MockDataService.shared
    
    var friends: [Friend] {
        dataService.mockFriends
    }
    
    var feelings: [Feeling] {
        dataService.mockFeelings
    }
    
    var hashtags: [Hashtag] {
        dataService.mockHashtags
    }
    
    var categories: [Category] {
        dataService.mockCategoriesData
    }
    
    var transactions: [Transaction] {
        dataService.mockTransactionsData
    }
    
    var filteredFriends: [Friend] {
        
        let availableFriends = friends.filter { friend in
            !taggedFriends.contains { $0.id == friend.id }
        }
        
        if friendSearchText.isEmpty {
            return availableFriends
        } else {
            return availableFriends.filter { friend in
                friend.name.lowercased().contains(friendSearchText.lowercased())
            }
        }
    }
    
    var canPost: Bool {
        selectedTransaction != nil && selectedHashtag != nil && selectedFeeling != nil
    }
    
    func selectTransaction(_ transaction: Transaction) {
        
        if selectedTransaction?.id == transaction.id {
            
            selectedTransaction  = nil
            selectedCategory     = nil
            showCategoryDropdown = false
            
        } else {
            
            selectedTransaction  = transaction
            selectedCategory     = nil
            showCategoryDropdown = false
            
        }
    }
    
    func selectCategory(_ categoryName: String) {
        selectedCategory     = categoryName
        showCategoryDropdown = false
    }
    
    func selectHashtag(_ hashtag: String) {
        selectedHashtag = selectedHashtag == hashtag ? nil : hashtag
    }
    
    func selectFeeling(_ feeling: String) {
        selectedFeeling     = feeling
        showFeelingDropdown = false
    }
    
    func toggleCategoryDropdown() {
        if selectedTransaction != nil {
            showFeelingDropdown = false
            showFriendsDropdown = false
            friendSearchText    = ""

            showCategoryDropdown.toggle()
        }
    }

    func toggleFeelingDropdown() {
        showCategoryDropdown = false
        showFriendsDropdown = false
        friendSearchText = ""

        showFeelingDropdown.toggle()
    }

    func toggleFriendsDropdown() {
        showCategoryDropdown = false
        showFeelingDropdown = false

        showFriendsDropdown.toggle()
        friendSearchText = ""
    }

    func closeAllDropdowns() {
        showCategoryDropdown = false
        showFeelingDropdown = false
        showFriendsDropdown = false
        friendSearchText = ""
    }
    
    func tagFriend(_ friend: Friend) {
        guard taggedFriends.count < 5 else { return }
        
        if !taggedFriends.contains(where: { $0.id == friend.id }) {
            taggedFriends.append(friend)
        }
        
        showFriendsDropdown = false
        friendSearchText = ""
    }
    
    func removeFriend(_ friendId: String) {
        if let friendToRemove = taggedFriends.first(where: { $0.id == friendId }) {
            taggedFriends.removeAll { $0.id == friendId }
            
            let mention = "@\(friendToRemove.name)"
            postText = postText.replacingOccurrences(of: mention, with: "").trimmingCharacters(in: .whitespaces)
        }
    }
    
    var onPostCreated: (() -> Void)?
    
    func createPost() {
        guard let selectedTransaction = selectedTransaction,
              let selectedHashtag = selectedHashtag,
              let selectedFeeling = selectedFeeling else {
            return
        }
        
        let newPost = Post(
            id: UUID().uuidString,
            name: "George Garcia", // we can always update this later on. for now a static text to think that we are the current user
            amount: selectedTransaction.price,
            timestamp: "Just now",
            transaction: selectedTransaction.name,
            spendingStyle: selectedFeeling,
            likes: 0,
            comments: 0,
            category: selectedHashtag,
            title: postTitle.isEmpty ? nil : postTitle,
            caption: postText.isEmpty ? nil : postText,
            image: nil,
            taggedFriends: taggedFriends.isEmpty ? nil : taggedFriends
        )
        
        dataService.addPost(newPost)
        onPostCreated?()
        resetForm()
    }
    
    func resetForm() {
        postTitle            = ""
        postText             = ""
        selectedTransaction  = nil
        selectedHashtag      = nil
        selectedCategory     = nil
        showCategoryDropdown = false
        taggedFriends        = []
        showFriendsDropdown  = false
        friendSearchText     = ""
        selectedFeeling      = nil
        showFeelingDropdown  = false
    }
}
