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
    private var db = Firestore.firestore()
    init() {
        getAllPosts()
    }
    
    func getAllPosts() {
        //        self.posts = [Post(caption: "Example 1"), Post(caption: "Example 2"), Post(caption: "Example 3")]
        
        // Retrieve the "posts" document
        db.collection("posts").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            // Loop to get the "name" field inside each movie document
            self.posts = documents.map { (queryDocumentSnapshot) -> Post in
                let data = queryDocumentSnapshot.data()
                let caption = data["caption"] as? String ?? ""
                return Post(caption: caption)
            }
        }
    }
}
