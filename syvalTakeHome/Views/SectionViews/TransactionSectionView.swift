//  TransactionSectionView.swift
//  syvalTakeHome
//  Created by George Garcia on 6/2/25.

import SwiftUI

struct TransactionSectionView: View {
    
    @ObservedObject var viewModel: CreatePostViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Recent Transactions")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.primary)
                .padding(.horizontal, 20)
            
            VStack(spacing: 6) {
                ForEach(viewModel.transactions) { transaction in
                    Button(action: { viewModel.selectTransaction(transaction) }) {

                        let isSelected = viewModel.selectedTransaction?.id == transaction.id
                        let backgroundColor = isSelected ? Color(hex: "f0f0ff") : Color(UIColor.systemBackground)
                        let borderColor = isSelected ? Color(hex: "5643F4") : Color.gray.opacity(0.3)
                        
                        // Transaction content
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                // Transaction header
                                HStack {
                                    Text(transaction.name)
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundColor(.primary)
                                    
                                    Spacer()
                                    
                                    Text(transaction.price)
                                        .font(.system(size: 16, weight: .bold))
                                        .foregroundColor(Color(hex: "5643F4"))
                                }
                                
                                // Transaction details
                                HStack {
                                    Text(transaction.category)
                                        .font(.system(size: 14))
                                        .foregroundColor(.gray)
                                    
                                    Spacer()
                                    
                                    Text(transaction.date)
                                        .font(.system(size: 14))
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        .padding(16)
                        .background(backgroundColor)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(borderColor, lineWidth: 1)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding(.horizontal, 16)
        }
        .padding(.top, 16)
    }
}

#Preview {
    TransactionSectionView(viewModel: CreatePostViewModel())
}
