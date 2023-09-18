//
//  PostService.swift
//  SocialMediaApp
//
//  Created by Duong Anh Kiet on 18/09/2023.
//

import Foundation
import FirebaseFirestore


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
    
    func addNewPost (caption: String) {
        let db = Firestore.firestore()
        let userId = "gfa0WDjE6uSKvo8J9sIbQxr41v73"
        let timestamp = dateToString(date: Date())
        let data = [
            "caption": caption,
            "timestamp": timestamp,
            "userId": userId
        ] as [String : Any]
        db.collection("posts").addDocument(data: data)
    }
    
    func getAllPosts(completion: @escaping([Post]) -> Void){
        let db = Firestore.firestore()
        db.collection("posts").addSnapshotListener { querySnapshot, error in
            //            guard let documents = snapshot?.documents else { return }
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
                return Post(id: id, caption: caption, timestamp: date, userId: userId)
            }
            completion(posts)
        }
    }
    
    func getAllPosts(userId: String, completion: @escaping([Post]) -> Void) {
        let db = Firestore.firestore()
        db.collection("posts").whereField("userId", isEqualTo: userId)
            .getDocuments { querySnapshot, error in
//                guard let documents = snapshot?.documents else { return }
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
                    return Post(id: id, caption: caption, timestamp: date, userId: userId)
                }
                completion(posts)
            }
    }
    
    func deletePost(postId: String) {
        let db = Firestore.firestore()
        db.collection("posts").document(postId).delete()
    }
    
    func updatePost(postId: String, caption: String) {
        let db = Firestore.firestore()
        db.collection("posts").document(postId).updateData(["caption": caption])
    }
}
