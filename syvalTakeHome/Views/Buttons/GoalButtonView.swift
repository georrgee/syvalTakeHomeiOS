//  GoalButtonView.swift
//  syvalTakeHome
//  Created by George Garcia on 6/2/25


import SwiftUI

struct GoalButtonView: View {
    
    @ObservedObject var viewModel: CreatePostViewModel
    
    var body: some View {
        Button(action: viewModel.toggleGoalDropdown) {
            HStack(spacing: 4) {
                Image(systemName: "target")
                    .font(.system(size: 14))
                
                Text(viewModel.selectedGoal?.name ?? "Goal")
                    .font(.system(size: 14))
                    .lineLimit(1)
                
                Image(systemName: "chevron.down")
                    .font(.system(size: 10))
            }
            .foregroundColor(viewModel.selectedGoal != nil ? Color(hex: "5643F4") : .gray)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(Color.gray.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }
}
