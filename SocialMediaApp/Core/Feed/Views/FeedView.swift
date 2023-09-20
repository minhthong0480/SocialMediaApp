//
//  FeedView.swift
//  SocialMediaApp
//
//  Created by Hoang Hung on 14/09/2023.
//

import SwiftUI

struct FeedView: View {
    @ObservedObject var viewModel = FeedViewModel()
    @State private var searchText = ""
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(viewModel.posts) { post in
                    PostView(post: post)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading) {
//
//                }
                ToolbarItem(placement: .principal) {
                    Text("Tweeter")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.primary)
                }
//                ToolbarItem(placement: .navigationBarTrailing) {                
//                }
            }
        }
        .searchable(text: $searchText)
            .onChange(of: searchText){_ in
                viewModel.searchPosts(searchText: searchText)
            }
            .onSubmit(of: .search){
                viewModel.searchPosts(searchText: searchText)
            }
        
    }
}

//struct FeedView_Previews: PreviewProvider {
//    static var previews: some View {
//        FeedView()
//    }
//}
