//  HashtagSectionView.swift
//  syvalTakeHome
//  Created by George Garcia on 6/2/25

import SwiftUI

struct HashtagSectionView: View {
    
    @ObservedObject var viewModel: CreatePostViewModel
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 12) {
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(viewModel.hashtags) { hashtag in
                        Button(action: { viewModel.selectHashtag(hashtag.name) }) {

                            let isSelected = viewModel.selectedHashtag == hashtag.name
                            let textColor = isSelected ? Color.white : Color.gray
                            let backgroundColor = isSelected ? Color(hex: hashtag.color) : Color.gray.opacity(0.1)
                            
                            Text(hashtag.name)
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(textColor)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(backgroundColor)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.horizontal, 20)
            }
        }
        .padding(.top, 16)
    }
}

#Preview {
    HashtagSectionView(viewModel: CreatePostViewModel())
}
