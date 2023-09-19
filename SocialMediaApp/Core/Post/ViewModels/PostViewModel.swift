//
//  PostViewMode.swift
//  SocialMediaApp
//
//  Created by Hoang Hung on 14/09/2023.
//

import Foundation
import FirebaseFirestore

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
    
    func likePost() {
        postService.likePost(post: self.post)
//        self.post.isLiked = true
    }
    
    func unlikePost() {
        postService.unlikePost(post: self.post)
//        self.post.isLiked = false
    }
    
    func getUser(userId: String) {
        let db = Firestore.firestore()

        db.collection("users").document(userId).getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                let fullname = data?["fullname"] as? String ?? ""
                let email = data?["email"] as? String ?? ""
                let profileImageUrl = data?["profileImageUrl"] as? String ?? ""
                self.user = User(uid: document.documentID, fullname: fullname, email: email)
            } else {
                print("Document does not exist")
            }
        }
    }
}
