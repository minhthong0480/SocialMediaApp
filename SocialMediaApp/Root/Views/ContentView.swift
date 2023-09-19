//
//  ContentView.swift
//  SocialMediaApp
//
//  Created by Nguyen Hoang Minh Thong on 12/09/2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                TabView {
                    FeedView()
                        .tabItem {
                            Label("Feed", systemImage: "house.fill")
                        }
                    ProfileView()
                        .tabItem {
                            Label("Profile", systemImage: "person.fill")
                        }
                    NewPostView()
                        .tabItem {
                            Label("New Post", systemImage: "plus.app.fill")
                        }
                }
            } else {
                LoginView(recentSignIn: RecentSignIn())
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AuthViewModel())
        
    }
}
