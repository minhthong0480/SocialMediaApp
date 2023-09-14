//
//  Post.swift
//  SocialMediaApp
//
//  Created by Hoang Hung on 14/09/2023.
//

import Foundation
import SwiftUI

struct Post: Decodable, Identifiable {
    let id = UUID()
    let caption: String
    let timestamp: Date
    
    init (caption: String) {
        self.caption = caption
        timestamp = Date()
    }
//    let user: User
}
