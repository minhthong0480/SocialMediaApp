/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Duong Anh Kiet
  ID: s3891487
  Created  date: 14/09/2023
  Last modified: 22/09/2023
  Acknowledgement:
    https://firebase.google.com/docs/firestore/query-data/listen
    https://firebase.google.com/docs/database/ios/read-and-write
    https://www.hackingwithswift.com/example-code/system/how-to-convert-dates-and-times-to-a-string-using-dateformatter
    https://github.com/TomHuynhSG/Movie-List-Firestore-iOS-Firebase
*/

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




