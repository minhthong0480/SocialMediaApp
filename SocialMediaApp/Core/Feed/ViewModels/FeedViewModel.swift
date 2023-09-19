//
//  FeedViewModel.swift
//  SocialMediaApp
//
//  Created by Hoang Hung on 14/09/2023.
//

import Foundation
import FirebaseFirestore

class FeedViewModel: ObservableObject {
    @Published var posts = [Post]()
    private let postService = PostService()
    
    init() {
        getAllPosts()
    }
    
    func getAllPosts() {
//        let userId = "2fmKZzUCfEeg2tKbU620LsE00H33"
        postService.getAllPosts(){ posts in
//            self.posts = posts
            
            // Sort post array by date in descending order
            var sortedPosts = posts.sorted(by: { $0.timestamp.compare($1.timestamp) == .orderedDescending })
            self.posts = sortedPosts

        }
    }
    
    func searchPosts(searchText: String){
        postService.getAllPosts(){ posts in
            var searchedPosts = [Post]()
            if searchText.isEmpty{
                searchedPosts = posts.sorted(by: { $0.timestamp.compare($1.timestamp) == .orderedDescending })
            }else{
                searchedPosts = posts.filter({$0.caption.localizedCaseInsensitiveContains(searchText)})
            }
            self.posts = searchedPosts
        }
    }
}
