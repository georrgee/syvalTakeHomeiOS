//  Post.swift
//  syvalTakeHome
//  Created by George Garcia on 6/2/25.

import Foundation

struct Post: Identifiable, Codable {
    let id:            String
    let name:          String
    let amount:        String
    let timestamp:     String
    let transaction:   String
    let spendingStyle: String?
    let likes:         Int?
    let comments:      Int?
    let category:      String?
    let title:         String?
    let caption:       String?
    let image:         String?
    let taggedFriends: [Friend]?
    let linkedGoal:    LinkedGoal?
}

struct LinkedGoal: Codable {
    let goalId: String
    let goalName: String
    let progressImpact: Double
}
