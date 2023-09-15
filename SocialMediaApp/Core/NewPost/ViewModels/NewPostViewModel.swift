//
//  NewPostViewModel.swift
//  SocialMediaApp
//
//  Created by Duong Anh Kiet on 14/09/2023.
//

import Foundation
import FirebaseFirestore

class NewPostViewModel: ObservableObject {
    
    private var db = Firestore.firestore()
    
    func addNewPost (caption: String) {
        db.collection("posts").addDocument(data: ["caption": caption])
    }
}




