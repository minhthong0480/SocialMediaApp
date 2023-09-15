//
//  Post.swift
//  SocialMediaApp
//
//  Created by Hoang Hung on 14/09/2023.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct Post: Identifiable {
    var id: String = UUID().uuidString
    let caption: String
    let timestamp: Date
    let userId: String
}
