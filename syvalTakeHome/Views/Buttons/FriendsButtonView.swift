//  FriendsButtonView.swift
//  syvalTakeHome
//  Created by George Garcia on 6/2/25

import SwiftUI

struct FriendsButtonView: View {
    
    @ObservedObject var viewModel: CreatePostViewModel
    
    var body: some View {
        Button(action: viewModel.toggleFriendsDropdown) {
            ZStack {
                Circle()
                    .fill(viewModel.taggedFriends.isEmpty ? Color.clear : Color(hex: "5643F4"))
                    .frame(width: 36, height: 36)
                
                Image(systemName: "at")
                    .font(.title2)
                    .foregroundColor(viewModel.taggedFriends.isEmpty ? Color(hex: "5643F4") : .white)
                
                if !viewModel.taggedFriends.isEmpty {
                    Text("\(viewModel.taggedFriends.count)")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 18, height: 18)
                        .background(Color.red)
                        .clipShape(Circle())
                        .offset(x: 14, y: -14)
                }
            }
            .frame(width: 48, height: 48)
        }
    }
}

#Preview {
    FriendsButtonView(viewModel: CreatePostViewModel())
}
