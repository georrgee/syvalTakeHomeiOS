//  HomeViewModel.swift
//  syvalTakeHome
//  Created by George Garcia on 6/2/25.

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    
    @Published var posts: [Post] = []
    @Published var isCreatePostVisible = false
    
    private let dataService = MockDataService.shared
    
    init() {
        loadPosts()
    }
    
    func loadPosts() {
        posts = dataService.postsData
    }
    
    func showCreatePost() {
        isCreatePostVisible = true
    }
    
    func hideCreatePost() {
        isCreatePostVisible = false
    }
}
