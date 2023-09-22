/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Nguyen Hieu Duc Duy
  ID: s3930426
  Created  date: 16/9/2023
  Last modified: 22/09/2023
  Acknowledgement: Lectures
*/

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
