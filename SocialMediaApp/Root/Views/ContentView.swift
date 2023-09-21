//
//  ContentView.swift
//  SocialMediaApp
//
//  Created by Nguyen Hoang Minh Thong on 12/09/2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @AppStorage("darkModeEnabbled") private var darkModeEnabled = false
    
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                TabView {
                    if let currentUser = viewModel.currentUser {
                        FeedView(user: currentUser)
                            .tabItem {
                                Label("Feed", systemImage: "house.fill")
                            }
                    }
                    ProfileView(darkModeEnabled: $darkModeEnabled)
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
        .onAppear {
                    ThemeManager
                        .shared
                        .handleTheme(darkMode: darkModeEnabled)
                }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AuthViewModel())
        
    }
}
