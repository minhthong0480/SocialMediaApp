//
//  AuthViewModel.swift
//  SocialMediaApp
//
//  Created by Nguyen Hoang Minh Thong on 15/09/2023.
//

import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseFirestoreSwift
import FirebaseFirestore
import Firebase
import LocalAuthentication

protocol AuthFormProtocol {
    var validForm: Bool {get}
}

@MainActor
class AuthViewModel: ObservableObject {
    @ObservedObject var recentSignIn: RecentSignIn
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init(){
        self.userSession = Auth.auth().currentUser
        
        Task{
            await fetchUser()
        }
    }
    // MARK: Credential Authentication
    func signIn(withEmail email: String, password: String) async throws {
        do{
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
        } catch{
            print("DEBUG: Failed to log in. Error \(error.localizedDescription)")
        }
    }
    
    func createUser(withEmail email: String, password: String, fullname: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, fullname: fullname, email: email)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchUser()
        } catch {
            print("Error \(error.localizedDescription)")
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
        } catch {
            print("DEBUG: Failed to sign out. Error \(error.localizedDescription)")
        }
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else {return}
        self.currentUser = try?snapshot.data(as:User.self)
        
        print("DEBUG: Current user is: \(self.currentUser)")
    }
    
    // MARK: Biometric authentication
    private(set) var context = LAContext()
    private(set) var canEvaluatePolicy = false
    @Published private(set) var biometryType: LABiometryType = .none
    @Published private(set) var errorDescription: String?
    @Published var showAlert = false
    
    
    func getBiometryType() {
        canEvaluatePolicy = context.canEvaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            error: nil)
        biometryType = context.biometryType
    }
    
    
    func biometricSignin() async throws{
        
        // Retrieve last used Email
        guard let lastEmail = recentSignIn.recentAccount as? String else { return }
        
        let context = LAContext()
        
        if canEvaluatePolicy {
            let reason = "Log into a previously saved account"
            
            do {
                let success = try await context.evaluatePolicy(
                    .deviceOwnerAuthenticationWithBiometrics,
                    localizedReason: reason)
                
                if success {
                    DispatchQueue.main.async {
                        // Authenticate user here
                        try await self.signInWithSavedPassword(lastEmail)
                    }
                }
            } catch {
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self.errorDescription = error.localizedDescription
                    self.showAlert = true
                    self.biometryType = .none
                }
            }
        }
    }
    
    func signInWithSavedPassword( _ email: String ) async {
        guard !email.isEmpty else { return }
        let password = recentSignIn.getStoredPassword()
        do {
            try await self.signIn(withEmail: email, password: password)
        } catch {
            print("Unhandled Error")
        }
    }
}
