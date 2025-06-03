//  MockDataService.swift
//  syvalTakeHome
//  Created by George Garcia on 6/2/25.

import Foundation

class MockDataService {
    
    static let shared = MockDataService()
    
    private init() {}
    
    let mockFriends: [Friend] = [
        Friend(id: "1", name: "Haruka"),
        Friend(id: "2", name: "Rey Delgado"),
        Friend(id: "3", name: "Danica"),
        Friend(id: "4", name: "Matt Lee"),
        Friend(id: "5", name: "Jeff"),
        Friend(id: "6", name: "George Garcia")
    ]
    
    let mockFeelings: [Feeling] = [
        Feeling(id: "1", emoji: "😊", label: "Happy"),
        Feeling(id: "2", emoji: "😐", label: "Neutral"),
        Feeling(id: "3", emoji: "😞", label: "Sad")
    ]
    
    let mockHashtags: [Hashtag] = [
        Hashtag(id: "1", name: "#reflect", color: "FFEDB5"),
        Hashtag(id: "2", name: "#flex", color: "C4B8FE"),
        Hashtag(id: "3", name: "#reward", color: "51b06c"),
        Hashtag(id: "4", name: "#uncertain", color: "c8c5c6"),
        Hashtag(id: "5", name: "#necessary", color: "745ba5"),
        Hashtag(id: "6", name: "#supportive", color: "ec7aab")
    ]
    
    let mockCategoriesData: [Category] = [
        Category(name: "Bank Fees", emoji: "💵"),
        Category(name: "Clothing", emoji: "👕"),
        Category(name: "Coffee Shop", emoji: "☕"),
        Category(name: "Community", emoji: "🏘️"),
        Category(name: "Credit Card", emoji: "💳"),
        Category(name: "Education", emoji: "📚"),
        Category(name: "Entertainment", emoji: "🎭"),
        Category(name: "Food and Drink", emoji: "🍔"),
        Category(name: "Gas Stations", emoji: "⛽"),
        Category(name: "General Merchandise", emoji: "🛍️"),
        Category(name: "Groceries", emoji: "🥦"),
        Category(name: "Healthcare", emoji: "🏥"),
        Category(name: "Home Improvement", emoji: "🔨"),
        Category(name: "Loan", emoji: "🏦"),
        Category(name: "Mortgage", emoji: "🏡"),
        Category(name: "Payment", emoji: "💰"),
        Category(name: "Personal Care", emoji: "💆"),
        Category(name: "Recreation", emoji: "🏐"),
        Category(name: "Rent", emoji: "💸"),
        Category(name: "Restaurants", emoji: "🧑‍🍳"),
        Category(name: "Service", emoji: "🔧"),
        Category(name: "Shopping", emoji: "🛒"),
        Category(name: "Subscription", emoji: "📲"),
        Category(name: "Transfer", emoji: "🔁"),
        Category(name: "Transportation", emoji: "🚗"),
        Category(name: "Travel", emoji: "✈️"),
        Category(name: "Utilities", emoji: "💡")
    ]
    
    let mockTransactionsData: [Transaction] = [
        Transaction(id: "1", name: "Apple", category: "Shops", price: "$9.99", date: "Jun 2"),
        Transaction(id: "2", name: "Deposit George Garcia", category: "Transfer", price: "$100", date: "Jun 2"),
        Transaction(id: "3", name: "Payrange", category: "Service", price: "$10.00", date: "May 30"),
        Transaction(id: "4", name: "Safeway", category: "Groceries", price: "$22.00", date: "May 22"),
        Transaction(id: "5", name: "VolleyWorld", category: "Subscription", price: "$20.00", date: "May 22"),
    ]
    
    let mockGoals: [Goal] = [
        Goal(id: "1", name: "Vacation", targetAmount: 2000.0, currentAmount: 500.0, color: "4ECDC4"),
        Goal(id: "2", name: "Emergency Fund", targetAmount: 5000.0, currentAmount: 1000.0, color: "FF6B6B"),
        Goal(id: "3", name: "New Laptop", targetAmount: 1500.0, currentAmount: 750.0, color: "FFD166"),
        Goal(id: "4", name: "Home Down Payment", targetAmount: 20000.0, currentAmount: 5000.0, color: "06D6A0")
    ]
    
    var postsData: [Post] = [
        Post(
            id: "1",
            name: "George Garcia",
            amount: "$100.00",
            timestamp: "Just now",
            transaction: "Deposit Transfer",
            spendingStyle: "The Connector",
            likes: 8,
            comments: 12,
            category: "#reflect",
            title: "Birthday Present",
            caption: "Little bro gave me a birthday present. I feel bad that he sent me money. He is also looking for a job. But I know that it's all love and that the bad things are only temporary.",
            image: nil,
            taggedFriends: [],
            linkedGoal: LinkedGoal(goalId: "2", goalName: "Emergency Fund", progressImpact: 10.0)
        ),
        
        Post(
            id: "2",
            name: "Haruka",
            amount: "$11.50",
            timestamp: "3h",
            transaction: "Saluhall Market Food & Drink",
            spendingStyle: "The Indulger",
            likes: 500,
            comments: 526,
            category: "#flex",
            title: nil,
            caption: "Feeling productive every day and I love it! Thought I should treat myself for all the hard work...",
            image: "https://via.placeholder.com/100",
            taggedFriends: [Friend(id: "6", name: "George")],
            linkedGoal: LinkedGoal(goalId: "1", goalName: "Savings", progressImpact: 200.0)
        ),
        Post(
            id: "3",
            name: "Danica",
            amount: "$526.92",
            timestamp: "5h",
            transaction: "La Mar",
            spendingStyle: "The Supporter",
            likes: 42,
            comments: 5,
            category: "#flex",
            title: nil,
            caption: "Great dinner for George's birthday",
            image: "https://via.placeholder.com/101",
            taggedFriends: [Friend(id: "2", name: "Rey Delgado"), Friend(id: "6", name: "George")],
            linkedGoal: LinkedGoal(goalId: "3", goalName: "Budgeting", progressImpact: 20.0)

        )
    ]
    
    func addPost(_ post: Post) {
        postsData.insert(post, at: 0)
    }
}
