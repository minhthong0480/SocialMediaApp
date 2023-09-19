//
//  Post.swift
//  SocialMediaApp
//
//  Created by Duong Anh Kiet on 19/09/2023.
//

import Foundation
import SwiftUI

struct Post: Identifiable {
    var id: String = UUID().uuidString
    let caption: String
    let timestamp: Date
    let userId: String
    let likes: Int
    var isLiked: Bool
}
