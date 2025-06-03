//  HomeView.swift
//  syvalTakeHome
//  Created by George Garcia on 6/2/25

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 0) {
                    // Header
                    HStack {
                        Text("For you")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color(hex: "5643F4"))
                        
                        Spacer()
                        
                        HStack(spacing: 20) {
                            Button(action: {}) {
                                Image(systemName: "person.2")
                                    .foregroundColor(Color(hex: "5643F4"))
                                    .font(.title2)
                            }
                            
                            Button(action: {}) {
                                Image(systemName: "bell")
                                    .foregroundColor(Color(hex: "5643F4"))
                                    .font(.title2)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    
                    // Posts List
                    ScrollView {
                        LazyVStack(spacing: 8) {
                            ForEach(viewModel.posts) { post in
                                PostView(post: post)
                            }
                        }
                        .padding(.top)
                    }
                }
                
                // Floating Action Button
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: viewModel.showCreatePost) {
                            Image(systemName: "plus")
                                .font(.title2)
                                .foregroundColor(.white)
                                .frame(width: 56, height: 56)
                                .background(Color(hex: "5643F4"))
                                .clipShape(Circle())
                                .shadow(radius: 8)
                        }
                        .padding(.trailing, 30)
                        .padding(.bottom, 40)
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .fullScreenCover(isPresented: $viewModel.isCreatePostVisible) {
            CreatePostView(isPresented: $viewModel.isCreatePostVisible,
                onPostCreated: {
                    viewModel.refreshPosts()
                })
        }
    }
}

#Preview {
    HomeView()
}
