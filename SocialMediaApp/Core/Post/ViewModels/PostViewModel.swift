//
//  PostViewMode.swift
//  SocialMediaApp
//
//  Created by Hoang Hung on 14/09/2023.
//

import Foundation

class PostViewModel: ObservableObject {
    @Published var post: Post
    private let postService = PostService()
    init(post: Post) {
        self.post = post
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
}
