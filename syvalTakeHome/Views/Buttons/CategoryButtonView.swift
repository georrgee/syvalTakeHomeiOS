//  CategoryButtonView.swift
//  syvalTakeHome
//  Created by George Garcia on 6/2/25

import SwiftUI

struct CategoryButtonView: View {
    
    @ObservedObject var viewModel: CreatePostViewModel
    
    var body: some View {
        let isSelected = viewModel.selectedCategory != nil
        let textColor = isSelected ? Color.white : Color(hex: "5643F4")
        let backgroundColor = isSelected ? Color(hex: "5643F4") : Color.clear
        let iconName = viewModel.showCategoryDropdown ? "chevron.up" : "chevron.down"
        
        return Button(action: viewModel.toggleCategoryDropdown) {
            HStack {
                Text(viewModel.selectedCategory ?? "Category")
                    .foregroundColor(textColor)
                    .font(.system(size: 14, weight: .medium))
                    .lineLimit(1)
                    .truncationMode(.tail)
                Image(systemName: iconName)
                    .foregroundColor(textColor)
                    .font(.system(size: 12))
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .frame(minWidth: 80, maxWidth: 140)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
        .disabled(viewModel.selectedTransaction == nil)
        .opacity(viewModel.selectedTransaction == nil ? 0.5 : 1.0)
    }
}
