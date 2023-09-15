//
//  SocialMediaAppApp.swift
//  SocialMediaApp
//
//  Created by Nguyen Hoang Minh Thong on 12/09/2023.
//

import SwiftUI
import Firebase


@main
struct SocialMediaAppApp: App {
    
    @StateObject var viewModel = AuthViewModel()
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
