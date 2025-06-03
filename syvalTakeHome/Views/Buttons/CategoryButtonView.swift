//  CategoryButtonView.swift
//  syvalTakeHome
//  Created by George Garcia on 6/2/25

import SwiftUI

struct CategoryButtonView: View {
    
    @ObservedObject var viewModel: CreatePostViewModel
    
    var body: some View {
        Button(action: viewModel.toggleCategoryDropdown) {
            HStack {
                Text(viewModel.selectedCategory ?? "Category")
                    .foregroundColor(viewModel.selectedCategory != nil ? .white : Color(hex: "5643F4"))
                    .font(.system(size: 14, weight: .medium))
                    .lineLimit(1)
                    .truncationMode(.tail)
                Image(systemName: viewModel.showCategoryDropdown ? "chevron.up" : "chevron.down")
                    .foregroundColor(viewModel.selectedCategory != nil ? .white : Color(hex: "5643F4"))
                    .font(.system(size: 12))
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .frame(minWidth: 80, maxWidth: 140)
            .background(viewModel.selectedCategory != nil ? Color(hex: "5643F4") : Color.clear)
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
        .disabled(viewModel.selectedTransaction == nil)
        .opacity(viewModel.selectedTransaction == nil ? 0.5 : 1.0)
    }
}
