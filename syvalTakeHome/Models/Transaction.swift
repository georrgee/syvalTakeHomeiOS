//  Transaction.swift
//  syvalTakeHome
//  Created by George Garcia on 6/2/25.

struct Transaction: Identifiable, Codable {
    let id:       String
    let name:     String
    let category: String
    let price:    String
    let date:     String
}
