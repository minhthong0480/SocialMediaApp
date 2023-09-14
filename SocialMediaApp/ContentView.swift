//
//  ContentView.swift
//  SocialMediaApp
//
//  Created by Nguyen Hoang Minh Thong on 12/09/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        //        VStack {
        //            Image(systemName: "globe")
        //                .imageScale(.large)
        //                .foregroundColor(.accentColor)
        //            Text("Assignment 3")
        //        }
        //        .padding()
        TabView {
            FeedView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
            NewPostView()
                .tabItem {
                    Label("New post", systemImage: "note.text.badge.plus")
                }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
