//
//  FeedViewModel.swift
//  SocialMediaApp
//
//  Created by Hoang Hung on 14/09/2023.
//

import Foundation

class FeedViewModel: ObservableObject {
    @Published var posts = [Post]()
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        self.posts = [Post(caption: "Example 1"), Post(caption: "Example 2"), Post(caption: "Example 3")]
    }
}
