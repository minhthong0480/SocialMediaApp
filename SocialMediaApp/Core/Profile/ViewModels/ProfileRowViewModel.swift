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
