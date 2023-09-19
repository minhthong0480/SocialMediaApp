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
