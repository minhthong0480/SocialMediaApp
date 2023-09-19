//
//  NewPostViewModel.swift
//  SocialMediaApp
//
//  Created by Duong Anh Kiet on 14/09/2023.
//

import Foundation
import FirebaseFirestore
import Firebase

class NewPostViewModel: ObservableObject {
    private let postService = PostService()
    
    func addNewPost (caption: String, currentUserId: String) {
        postService.addNewPost(caption: caption, userId: currentUserId)
    }
}




