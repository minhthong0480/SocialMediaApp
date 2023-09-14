//
//  SignupViewModel.swift
//  SocialMediaApp
//
//  Created by Nguyen Hoang Minh Thong on 15/09/2023.
//

import Foundation
import SwiftUI
import Firebase

class SignUp: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init(){
        
    }
    
    func signUp(){
        Auth.auth().createUser(withEmail: email, password: password){authResult, error in
            if error != nil{
                print(error?.localizedDescription ?? "")
                signUpSuccess = false
            }else {
                print("success")
                signUpSuccess = true
            }
        }
        
    }
}
