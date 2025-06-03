//  FeelingButtonView.swift
//  syvalTakeHome
//  Created by George Garcia on 6/2/25

import SwiftUI

struct FeelingButtonView: View {
    
    @ObservedObject var viewModel: CreatePostViewModel
    
    var body: some View {
        VStack {
            Button(action: viewModel.toggleFeelingDropdown) {
                HStack {
                    Text(viewModel.selectedFeeling ?? "�")
                        .font(.system(size: 18))
                    
                    Image(systemName: viewModel.showFeelingDropdown ? "chevron.up" : "chevron.down")
                        .font(.system(size: 16))
                        .foregroundColor(viewModel.selectedFeeling != nil ? .white : Color(hex: "5643F4"))
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(viewModel.selectedFeeling != nil ? Color(hex: "5643F4") : Color.clear)
                .clipShape(RoundedRectangle(cornerRadius: 24))
                .frame(minWidth: 60, minHeight: 48)
            }
            
            if viewModel.showFeelingDropdown {
                VStack(spacing: 0) {
                    // Header
                    Text("How do you feel about this?")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.primary)
                        .padding(16)
                        .frame(maxWidth: .infinity)
                        .background(Color.clear)
                    
                    // Feelings list
                    ForEach(viewModel.feelings) { feeling in
                        Button(action: { viewModel.selectFeeling(feeling.emoji) }) {
                            HStack {
                                Text(feeling.emoji)
                                    .font(.system(size: 22))
                                
                                Text(feeling.label)
                                    .font(.system(size: 15))
                                    .foregroundColor(.primary)
                                
                                Spacer()
                            }
                            .padding(16)
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        if feeling.id != viewModel.feelings.last?.id {
                            Divider()
                        }
                    }
                }
                .background(Color(UIColor.systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .shadow(radius: 8)
                .frame(minWidth: 150)
                .offset(x: -25)
            }
        }
    }
}

#Preview {
    FeelingButtonView(viewModel: CreatePostViewModel())
}
