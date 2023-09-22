/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Nguyen Hoang Minh Thong
  ID: s3852882
  Created  date: 13/9/2023
  Last modified: 22/09/2023
  Acknowledgement:
  - https://www.youtube.com/watch?v=7UKUCZuaVlA&t=16202s
  - https://www.youtube.com/watch?v=WehPyIuSlKg
  - https://www.youtube.com/watch?v=xhOFZyJW_1c
  - https://www.youtube.com/watch?v=NvcSgCKLX_0&t=596s
  - https://www.youtube.com/watch?v=3pIXMwvJLZs
*/

//
//  UserModel.swift
//  SocialMediaApp
//
//  Created by Nguyen Hoang Minh Thong on 13/09/2023.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseCore

struct User: Identifiable, Codable {
    @DocumentID var uid: String?
    var fullname: String
    let email: String
    var profileImageUrl: String?
    var likedPosts: [String]
    
    //let birthdate: Date
    
    var id: String {
        return uid ?? NSUUID().uuidString
    }
 
//    init(data: [String: Any]) {
//            self.uid = data["id"] as? String ?? ""
//            self.fullname = data["fullname"] as? String ?? ""
//            self.email = data["email"] as? String ?? ""
//            self.profileImageUrl = data["profileImageUrl"] as? String ?? ""
//        }
}
