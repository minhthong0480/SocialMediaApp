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
                let timestamp = data["timestamp"] as? String ?? ""
                let date = self.stringToDate(string: timestamp)
                return Post(caption: caption, timestamp: date)
            }
        }
        
    }
}
