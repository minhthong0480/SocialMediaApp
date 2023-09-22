/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Nguyen Hoang Vinh Hung
  ID: s3911246
  Created  date: 14/09/2023
  Last modified: 22/09/2023
  Acknowledgement:
    https://firebase.google.com/docs/firestore/query-data/listen
    https://firebase.google.com/docs/database/ios/read-and-write
    https://www.hackingwithswift.com/example-code/system/how-to-convert-dates-and-times-to-a-string-using-dateformatter
    https://github.com/TomHuynhSG/Movie-List-Firestore-iOS-Firebase
*/


//
//  PostViewMode.swift
//  SocialMediaApp
//
//  Created by Hoang Hung on 14/09/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class PostViewModel: ObservableObject {
    @Published var post: Post
    @Published var user: User?
    
    private let postService = PostService()
    init(post: Post) {
        self.post = post
        getUser(userId: post.userId)
    }
    
    func deletePost() {
        postService.deletePost(postId: post.id)
    }
    
    func updatePost(caption: String) {
        postService.updatePost(postId: post.id, caption: caption)
    }
    
    func likePost(userId: String) {
        postService.likePost(post: self.post)
        self.post.isLiked = true
        
        let db = Firestore.firestore()
        db.collection("users").document(userId).updateData([
            "likedPosts": FieldValue.arrayUnion([self.post.id])
        ])
    }
    
    func unlikePost(userId: String) {
        postService.unlikePost(post: self.post)
        self.post.isLiked = false
        
        let db = Firestore.firestore()
        db.collection("users").document(userId).updateData([
            "likedPosts": FieldValue.arrayRemove([self.post.id])
        ])
    }
    
    func getUser(userId: String) {
        let db = Firestore.firestore()
        
        db.collection("users").document(userId).getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                let fullname = data?["fullname"] as? String ?? ""
                let email = data?["email"] as? String ?? ""
                let profileImageUrl = data?["profileImageUrl"] as? String ?? ""
                let likedPosts = data?["likedPosts"] as? [String] ?? [String]()
                self.user = User(uid: document.documentID, fullname: fullname, email: email, profileImageUrl: profileImageUrl, likedPosts: likedPosts)
            } else {
                print("Document does not exist")
            }
        }
    }
}
