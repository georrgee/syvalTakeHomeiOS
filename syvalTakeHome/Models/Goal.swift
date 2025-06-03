//  Goal.swift
//  syvalTakeHome
//  Created by George Garcia on 6/3/25

import Foundation

struct Goal: Identifiable, Codable {
    let id: String
    let name: String
    let targetAmount: Double
    let currentAmount: Double
    let color: String
    
    var progressPercentage: Double {
        return min(currentAmount / targetAmount, 1.0) * 100
    }
}
