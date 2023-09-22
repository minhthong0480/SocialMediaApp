/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Duong Anh Kiet
  ID: s3891487
  Created  date: 18/09/2023
  Last modified: 22/09/2023
  Acknowledgement:
    https://firebase.google.com/docs/firestore/query-data/listen
    https://firebase.google.com/docs/database/ios/read-and-write
    https://www.hackingwithswift.com/example-code/system/how-to-convert-dates-and-times-to-a-string-using-dateformatter
    https://github.com/TomHuynhSG/Movie-List-Firestore-iOS-Firebase
*/


//
//  FeedView.swift
//  SocialMediaApp
//
//  Created by Hoang Hung on 14/09/2023.
//

import SwiftUI

struct FeedView: View {
    @ObservedObject var viewModel: FeedViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var searchText = ""
    @State private var filterOption = ""
    private let filterOptions = ["Latest", "Oldest", "Liked"]
    private let appName = "Connect"
    init (user: User) {
        self.viewModel = FeedViewModel(user: user)
    }
    
    var body: some View {
        NavigationView {
            
            ScrollView {
                ForEach(self.viewModel.filteredPosts) { post in
                    PostView(post: post)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(appName)
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.primary)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Picker("Filter", selection: $filterOption) {
                        ForEach(filterOptions, id: \.self) {
                            Text($0).tag($0)
                        }
                    }
                    .onChange(of: filterOption) { key in
                        viewModel.filterPosts(key: key)
                    }
                }
            }
        }
        .searchable(text: $searchText)
        .onChange(of: searchText) {_ in
            viewModel.searchPosts(searchText: searchText)
        }
        .onSubmit(of: .search) {
            viewModel.searchPosts(searchText: searchText)
        }
        
    }
}

//struct FeedView_Previews: PreviewProvider {
//    static var previews: some View {
//        FeedView()
//    }
//}
