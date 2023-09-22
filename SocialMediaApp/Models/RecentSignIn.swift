/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Ngo Chi Binh
  ID: s3938145
  Created  date: 16/09/2023
  Last modified: 22/09/2023
  Acknowledgement:
    https://github.com/ashislaha/LocalAuthentication
*/

//
//  RecentPassword.swift
//  SocialMediaApp
//
//  Created by Binh Ngo on 16/09/2023.
//

import SwiftUI

class RecentSignIn: ObservableObject {
    
    let accKey = "RecentAcc"
    
    @Published var recentAccount: String? {
        didSet {
            UserDefaults.standard.set(recentAccount, forKey: accKey)
            print("Recent Signin Email: \(recentAccount ?? "No recent sign in")")
            
            let pass = getStoredPassword()
            print("Recent Sigin Password: \(pass)")
        }
    }
    
    var isPasswordBlank: Bool {
        getStoredPassword() == ""
    }
    
    func getStoredPassword() -> String {
        let kcw = KeychainWrapper()
        if let password = try? kcw.getRecentPassword(
            account: "RecentPassword",
            service: "appPassword") {
            return password
        }
        return ""
    }
    
    func updateStoredPassword(_ password: String) {
        let kcw = KeychainWrapper()
        do {
            try kcw.storeRecentPassword(
                account: "RecentPassword",
                service: "appPassword",
                password: password)
        } catch let error as KeychainWrapperError {
            print("Exception setting password: \(error.message ?? "no message")")
        } catch {
            print("An error occurred setting the password")
        }
        // DEBUG: Show saved password
        print("Saved Password: \(password)")
    }
    
    func validatePassword(_ password: String) -> Bool {
        let currentPassword = getStoredPassword()
        return password == currentPassword
    }
    
    func changePassword(currentPassword: String, newPassword: String) -> Bool{
        guard validatePassword(currentPassword) == true else {return false}
        updateStoredPassword(newPassword)
        return true
    }
    
    init() {
        recentAccount = UserDefaults.standard.string(forKey: accKey) ?? ""
    }
}
