/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Duong Anh Kiet
  ID: s3891487
  Created  date: 18/09/2023
  Last modified: 22/09/2023
  Acknowledgement:
    https://firebase.google.com/docs/firestore/query-data/listen
    https://firebase.google.com/docs/database/ios/read-and-write
    https://www.hackingwithswift.com/example-code/system/how-to-convert-dates-and-times-to-a-string-using-dateformatter
    https://github.com/TomHuynhSG/Movie-List-Firestore-iOS-Firebase
*/

//
//  PostService.swift
//  SocialMediaApp
//
//  Created by Duong Anh Kiet on 18/09/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


struct PostService {
    //    let db = Firestore.firestore()
    
    func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm E, d MMM y"
        return formatter.string(from: date)
    }
    
    func stringToDate(string: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm E, d MMM y"
        return formatter.date(from: string) ?? Date()
    }
    
    func addNewPost(caption: String, userId: String) {
        let db = Firestore.firestore()
        
        // Generate data for new post
        let timestamp = dateToString(date: Date())
        let data = [
            "caption": caption,
            "timestamp": timestamp,
            "userId": userId,
            "likes": 0,
            "isLiked": false
        ] as [String : Any]
        
        // Save new post to database
        db.collection("posts").addDocument(data: data)
    }
    
    func getAllPosts(completion: @escaping([Post]) -> Void){
        let db = Firestore.firestore()
        
        db.collection("posts").addSnapshotListener { querySnapshot, error in
            
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(error!)")
                return
            }
            
            let posts = documents.map { (queryDocumentSnapshot) -> Post in
                let data = queryDocumentSnapshot.data()
                let id = queryDocumentSnapshot.documentID
                let caption = data["caption"] as? String ?? ""
                let timestamp = data["timestamp"] as? String ?? ""
                let date = self.stringToDate(string: timestamp)
                let userId = data["userId"] as? String ?? ""
                let likes = data["likes"] as? Int ?? 0
                let isLiked = data["isLiked"] as? Bool ?? false
                return Post(id: id, caption: caption, timestamp: date, userId: userId, likes: likes, isLiked: isLiked)
            }
            
            completion(posts)
        }
    }
    
    func getAllPosts(userId: String, completion: @escaping([Post]) -> Void) {
        let db = Firestore.firestore()
        
        db.collection("posts").whereField("userId", isEqualTo: userId)
            .addSnapshotListener { querySnapshot, error in
                
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching documents: \(error!)")
                    return
                }
                
                var posts = documents.map { (queryDocumentSnapshot) -> Post in
                    let data = queryDocumentSnapshot.data()
                    let id = queryDocumentSnapshot.documentID
                    let caption = data["caption"] as? String ?? ""
                    let timestamp = data["timestamp"] as? String ?? ""
                    let date = self.stringToDate(string: timestamp)
                    let userId = data["userId"] as? String ?? ""
                    let likes = data["likes"] as? Int ?? 0
                    var isLiked = data["isLiked"] as? Bool ?? false
                    return Post(id: id, caption: caption, timestamp: date, userId: userId, likes: likes, isLiked: isLiked)
                }
                
                completion(posts)
            }
    }
    
    func deletePost(postId: String) {
        let db = Firestore.firestore()
        
        // Delete post in posts collection
        db.collection("posts").document(postId).delete()
        
        // Delete post in likedPosts array of users
        db.collection("users").whereField("likedPosts", arrayContains: postId).getDocuments{ (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let user = document.reference
                    user.updateData(["likedPosts": FieldValue.arrayRemove([postId])])
                }
            }
        }
    }
    
    func updatePost(postId: String, caption: String) {
        let db = Firestore.firestore()
        db.collection("posts").document(postId).updateData(["caption": caption])
    }
    
    func likePost(post: Post) {
        let db = Firestore.firestore()
        db.collection("posts").document(post.id).updateData(["likes": post.likes + 1])
    }
    
    func unlikePost(post: Post) {
        let db = Firestore.firestore()
        db.collection("posts").document(post.id).updateData(["likes": post.likes - 1])
    }
}
