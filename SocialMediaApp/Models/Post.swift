/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Duong Anh Kiet
  ID: s3891487
  Created  date: 19/09/2023
  Last modified: 22/09/2023
  Acknowledgement:
    https://github.com/TomHuynhSG/Movie-List-Firestore-iOS-Firebase
*/


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
    var likes: Int
    var isLiked: Bool
}
