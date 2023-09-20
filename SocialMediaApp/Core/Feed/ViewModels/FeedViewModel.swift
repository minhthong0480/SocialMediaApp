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
    @Published var currentUser = User(uid: "", fullname: "", email: "", likedPosts: [String]())
    private let postService = PostService()
    
    init(user: User) {
        self.currentUser = user
        getAllPosts()
    }
    
    func isLikedPost(postId: String) -> Bool {
        return self.currentUser.likedPosts.contains(postId)
    }
    
    func getAllPosts() {
        postService.getAllPosts(){ posts in
            
            // Sort post array by date in descending order
            var sortedPosts = posts.sorted(by: { $0.timestamp.compare($1.timestamp) == .orderedDescending })
            
            
            // Load liked posts
            for i in 0..<sortedPosts.count {
                if self.isLikedPost(postId: sortedPosts[i].id) {
                    sortedPosts[i].isLiked = true
                }
            }
            
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
