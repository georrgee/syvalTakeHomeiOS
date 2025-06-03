//  FeelingButtonView.swift
//  syvalTakeHome
//  Created by George Garcia on 6/2/25

import SwiftUI

struct FeelingButtonView: View {
    
    @ObservedObject var viewModel: CreatePostViewModel
    
    var body: some View {
        Button(action: viewModel.toggleFeelingDropdown) {
            HStack {
                Text(viewModel.selectedFeeling ?? "😶")
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
    }
}

#Preview {
    FeelingButtonView(viewModel: CreatePostViewModel())
}
