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
    
    private var db = Firestore.firestore()
    
    func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm E, d MMM y"
        return formatter.string(from: date)
    }
    
    func addNewPost (caption: String) {
        let userId = "gfa0WDjE6uSKvo8J9sIbQxr41v73"
        let timestamp = dateToString(date: Date())
        let data = [
            "caption": caption,
            "timestamp": timestamp,
            "userId": userId
        ] as [String : Any]
        db.collection("posts").addDocument(data: data)
    }
}




