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
                    Text("Tweeter")
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
        .onAppear() {
            self.viewModel.getAllPosts()
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
