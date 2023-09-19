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
    
    
//    func dateToString(date: Date) -> String {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "HH:mm E, d MMM y"
//        return formatter.string(from: date)
//    }
//
//    func addNewPost (caption: String) {
//        let db = Firestore.firestore()
//        let userId = "gfa0WDjE6uSKvo8J9sIbQxr41v73"
//        let timestamp = dateToString(date: Date())
//        let data = [
//            "caption": caption,
//            "timestamp": timestamp,
//            "userId": userId
//        ] as [String : Any]
//        db.collection("posts").addDocument(data: data)
//    }
    
    func addNewPost (caption: String) {
        postService.addNewPost(caption: caption)
    }
}




