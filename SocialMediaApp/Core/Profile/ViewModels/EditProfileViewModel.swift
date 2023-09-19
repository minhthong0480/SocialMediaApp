//
//  EditProfileViewModel.swift
//  SocialMediaApp
//
//  Created by Nguyen Hoang Minh Thong on 19/09/2023.
//

import Foundation

class EditProfileViewModel: ObservableObject {
//    @Published var profileImage = Image?
    @Published var user: User
    @Published var fullname = ""
    
    init(user: User){
        self.user = user
    }
    //MARK: - UPDATE USER DATA
//    func updateUser() {
//        //update profile image
//        var data = [String: Any]()
//
//        //update fullname
//        if !fullname.isEmpty && user.fullname != fullname {
//            data["fullname"] = fullname
//        }
//
//
//    }
    
    
    
}
