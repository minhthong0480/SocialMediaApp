//
//  UserModel.swift
//  SocialMediaApp
//
//  Created by Nguyen Hoang Minh Thong on 13/09/2023.
//

import Foundation

struct User: Identifiable, Codable{
    var id = NSUUID().uuidString
    let fullname: String
    let email: String
    var profileImageUrl: String?
    
    //let birthdate: Date
    
    
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullname){
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        
        return ""
    }
}

extension User {
    static var mockUser = User(id: NSUUID().uuidString, fullname: "Thong Nguyen", email: "thongtest1@gmail.com", profileImageUrl: "batman")
}
