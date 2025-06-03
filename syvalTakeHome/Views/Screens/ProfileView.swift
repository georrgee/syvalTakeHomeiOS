//  ProfileView.swift
//  syvalTakeHome
//  Created by George Garcia on 6/2/25.

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Profile")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
            }
            .navigationTitle("Profile")
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    ProfileView()
}
