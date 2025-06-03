//  CategoryButtonView.swift
//  syvalTakeHome
//  Created by George Garcia on 6/2/25

import SwiftUI

struct CategoryButtonView: View {
    
    @ObservedObject var viewModel: CreatePostViewModel
    
    var body: some View {
        VStack {
            Button(action: viewModel.toggleCategoryDropdown) {
                HStack {
                    Text(viewModel.selectedCategory ?? "Category")
                        .foregroundColor(viewModel.selectedCategory != nil ? .white : Color("5643F4"))
                    Image(systemName: viewModel.showCategoryDropdown ? "chevron.up" : "chevron.down")
                        .foregroundColor(viewModel.selectedCategory != nil ? .white : Color("5643F4"))
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(viewModel.selectedCategory != nil ? Color("5643F4") : Color.clear)
                .clipShape(RoundedRectangle(cornerRadius: 24))
            }
            .disabled(viewModel.selectedTransaction == nil)
            .opacity(viewModel.selectedTransaction == nil ? 0.5 : 1.0)
            
            if viewModel.showCategoryDropdown {
                VStack(spacing: 0) {
                    Text("Select Category")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray.opacity(0.1))
                    
                    ScrollView {
                        LazyVStack(spacing: 0) {
                            ForEach(viewModel.categories, id: \.name) { category in
                                Button(action: { viewModel.selectCategory(category.name) }) {
                                    HStack {
                                        Text(category.emoji)
                                            .font(.title2)
                                        Text(category.name)
                                            .foregroundColor(.primary)
                                        Spacer()
                                    }
                                    .padding()
                                }
                            }
                        }
                    }
                    .frame(maxHeight: 200)
                }
                .background(Color(UIColor.systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .shadow(radius: 8)
                .frame(width: 200)
            }
        }
    }
}
