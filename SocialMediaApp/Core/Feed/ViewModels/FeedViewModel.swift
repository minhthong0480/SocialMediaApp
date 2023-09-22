/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Duong Anh Kiet
  ID: s3891487
  Created  date: 14/09/2023
  Last modified: 22/09/2023
  Acknowledgement:
    https://firebase.google.com/docs/firestore/query-data/listen
    https://firebase.google.com/docs/database/ios/read-and-write
    https://www.hackingwithswift.com/example-code/system/how-to-convert-dates-and-times-to-a-string-using-dateformatter
    https://github.com/TomHuynhSG/Movie-List-Firestore-iOS-Firebase
*/


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
            
            // Load liked posts
            for i in 0..<sortedPosts.count {
                if self.isLikedPost(postId: sortedPosts[i].id) {
                    sortedPosts[i].isLiked = true
                } else {
                    sortedPosts[i].isLiked = false
                }
            }
            
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
