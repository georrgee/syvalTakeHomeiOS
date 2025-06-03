//  InsightsView.swift
//  syvalTakeHome
//  Created by George Garcia on 6/2/25.

import SwiftUI

struct InsightsView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Insights")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
            }
            .navigationTitle("Insights")
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    InsightsView()
}
