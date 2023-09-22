/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Nguyen Hieu Duc Duy
  ID: s3930426
  Created  date: 16/9/2023
  Last modified: 22/09/2023
  Acknowledgement:
  - https://www.youtube.com/watch?v=7UKUCZuaVlA&t=16202s
  - https://www.youtube.com/watch?v=WehPyIuSlKg
  - https://www.youtube.com/watch?v=xhOFZyJW_1c
  - https://www.youtube.com/watch?v=NvcSgCKLX_0&t=596s
  - https://www.youtube.com/watch?v=3pIXMwvJLZs
*/

//
//  ProfileRowViewModel.swift
//  SocialMediaTest
//
//  Created by Nguyen Hoang Minh Thong on 16/09/2023.
//

import Foundation
import SwiftUI

enum ProfileRowViewModel: Int, CaseIterable, Identifiable{
    
    case email
    case fullname
    case phonenumber
    case gender
    
    var title: String {
        switch self {
        case .email: return "Email"
        case .fullname: return "FullName"
        case .phonenumber: return "Phone Number"
        case .gender: return "Gender"
        }
    }
    
    var imageName: String {
        switch self {
        case .email: return "envelope"
        case .fullname: return "person"
        case .phonenumber: return "phone"
        case .gender: return "person.2"
        }
    }
    
    var id: Int {return self.rawValue}
}
