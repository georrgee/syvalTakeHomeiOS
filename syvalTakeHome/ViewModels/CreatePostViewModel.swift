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
        dataService.categories
    }
    
    var transactions: [Transaction] {
        dataService.mockTransactionsData
    }
    
    var filteredFriends: [Friend] {
        friends.filter { friend in
            friend.name.lowercased().contains(friendSearchText.lowercased()) &&
            !taggedFriends.contains { $0.id == friend.id }
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
    
    func toggleCategoryDropdown() {
        if selectedTransaction != nil {
            showCategoryDropdown.toggle()
        }
    }
    
    func selectHashtag(_ hashtag: String) {
        selectedHashtag = selectedHashtag == hashtag ? nil : hashtag
    }
    
    func selectFeeling(_ feeling: String) {
        selectedFeeling     = feeling
        showFeelingDropdown = false
    }
    
    func toggleFeelingDropdown() {
        showFeelingDropdown.toggle()
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
    
    func toggleFriendsDropdown() {
        showFriendsDropdown.toggle()
        friendSearchText = ""
    }
    
    func createPost() {
        print("Creating post: \(postTitle), \(postText)")
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
