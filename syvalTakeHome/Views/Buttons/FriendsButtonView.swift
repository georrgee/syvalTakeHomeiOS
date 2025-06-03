//  FriendsButtonView.swift
//  syvalTakeHome
//  Created by George Garcia on 6/2/25

import SwiftUI

struct FriendsButtonView: View {
    
    @ObservedObject var viewModel: CreatePostViewModel
    
    var body: some View {
        VStack {
            Button(action: viewModel.toggleFriendsDropdown) {
                ZStack {
                    Image(systemName: "at")
                        .font(.title2)
                        .foregroundColor(viewModel.taggedFriends.isEmpty ? Color(hex: "5643F4") : .white)
                        .frame(width: 48, height: 48)
                        .background(viewModel.taggedFriends.isEmpty ? Color.clear : Color(hex: "5643F4"))
                        .clipShape(Circle())
                    
                    if !viewModel.taggedFriends.isEmpty {
                        VStack {
                            HStack {
                                Spacer()
                                Text("\(viewModel.taggedFriends.count)")
                                    .font(.system(size: 11, weight: .bold))
                                    .foregroundColor(.white)
                                    .frame(width: 20, height: 20)
                                    .background(Color.red)
                                    .clipShape(Circle())
                                    .offset(x: 8, y: -8)
                            }
                            Spacer()
                        }
                    }
                }
            }
            
            if viewModel.showFriendsDropdown {
                VStack(spacing: 0) {
                    // Header with search
                    HStack {
                        TextField("Search friends", text: $viewModel.friendSearchText)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .font(.system(size: 16))
                        
                        Button(action: viewModel.toggleFriendsDropdown) {
                            Image(systemName: "xmark")
                                .foregroundColor(.gray)
                                .padding()
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    
                    // Friends list
                    ScrollView {
                        LazyVStack(spacing: 0) {
                            if viewModel.filteredFriends.isEmpty {
                                VStack {
                                    Text(viewModel.friendSearchText.isEmpty ? "All friends tagged" : "No friends found")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 14))
                                        .padding(20)
                                }
                            } else {
                                ForEach(viewModel.filteredFriends) { friend in
                                    Button(action: { viewModel.tagFriend(friend) }) {
                                        HStack {
                                            // Friend avatar
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
                                        .padding()
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                    
                                    if friend.id != viewModel.filteredFriends.last?.id {
                                        Divider()
                                            .padding(.leading, 60)
                                    }
                                }
                            }
                        }
                    }
                    .frame(maxHeight: 220)
                    
                    // Warning for max friends
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
                .background(Color(UIColor.systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .shadow(radius: 8)
                .frame(width: 250)
                .offset(x: -50)
            }
        }
    }
}

#Preview {
    FriendsButtonView(viewModel: CreatePostViewModel())
}
