//
//  AuthViewModel.swift
//  SocialMediaApp
//
//  Created by Nguyen Hoang Minh Thong on 15/09/2023.
//

import Foundation
import SwiftUI
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @State var email = ""
    @State var password = ""
    
    @State var signUpSuccess = false
    
    init(){
        
    }
    
    func signIn(withEmail email: String, password: String){
        print("Sign In")
    }
    
    func createUser(withEmail email: String, password: String, fullname: String) {
        print("create user")
    }
    
    func signOut() {
        
    }
    
    func deleteAccount() {
        
    }
    
    func fetchUser() {
        
    }
}
