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
    @Published var filteredPosts = [Post]()
    @Published var currentUser = User(uid: "", fullname: "", email: "", likedPosts: [String]())
    private let postService = PostService()
    
    init(user: User) {
        self.currentUser = user
        getAllPosts()
        getLikedPosts()
    }
    
    func isLikedPost(postId: String) -> Bool {
        return self.currentUser.likedPosts.contains(postId)
    }
    
    func getAllPosts() {
        postService.getAllPosts() { posts in
            
            // Sort post array by date in descending order
            var sortedPosts = posts.sorted(by: { $0.timestamp.compare($1.timestamp) == .orderedDescending })
            
            self.posts = sortedPosts
            self.filteredPosts = sortedPosts
        }
    }
    
    func getLikedPosts () {
        let db = Firestore.firestore()
        
        db.collection("users").document(currentUser.uid ?? "unknown").addSnapshotListener { (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                let likedPosts = data?["likedPosts"] as? [String] ?? [String]()
                self.currentUser.likedPosts = likedPosts
                
                // Load liked posts
                var temp = self.posts
                for i in 0..<temp.count {
                    if likedPosts.contains(temp[i].id) {
                        temp[i].isLiked = true
                    } else {
                        temp[i].isLiked = false
                    }
                }
                self.posts = temp
                self.filteredPosts = temp
            } else {
                print("Document does not exist")
            }
        }
    }
    
    func searchPosts(searchText: String) {
        var searchedPosts = self.posts
        if searchText.isEmpty {
            searchedPosts = self.posts.sorted(by: { $0.timestamp.compare($1.timestamp) == .orderedDescending })
        } else{
            searchedPosts = self.posts.filter({$0.caption.localizedCaseInsensitiveContains(searchText)})
        }
        self.filteredPosts = searchedPosts
    }
    
    func filterPosts(key: String) {
        var filteredPosts = self.posts
        if key == "Oldest" {
            filteredPosts = self.posts.sorted(by: { $0.timestamp.compare($1.timestamp) == .orderedAscending })
        } else if key == "Latest" {
            filteredPosts = self.posts.sorted(by: { $0.timestamp.compare($1.timestamp) == .orderedDescending })
        } else if key == "Liked" {
            filteredPosts = self.posts.filter({$0.isLiked == true})
        }
        
        self.filteredPosts = filteredPosts
    }
    
}
