//  ContentView.swift
//  syvalTakeHome
//  Created by George Garcia on 6/2/25.

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        
        TabView {
            
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
             
            InsightsView()
                .tabItem {
                    Image(systemName: "lightbulb")
                    Text("Insights")
                }
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person.circle")
                    Text("Profile")
                }
        }
        .accentColor(Color(hex: "5643F4"))
    }
}

#Preview {
    ContentView()
}
