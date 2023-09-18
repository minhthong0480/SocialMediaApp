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

class AuthViewModel: ObservableObject {
    @ObservedObject var recentSignIn: RecentSignIn
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    private(set) var context = LAContext()
    private(set) var canEvaluatePolicy = false
    @Published private(set) var biometryType: LABiometryType = .none
    @Published private(set) var errorDescription: String?
    @Published var showAlert = false
    
    init(){
        self.userSession = Auth.auth().currentUser
        self.recentSignIn = RecentSignIn()
        self.getBiometryType()
        Task{
            await fetchUser()
        }
    }
    
    // MARK: - SIGN IN FUNC
    @MainActor
    func signIn(withEmail email: String, password: String) async throws {
        do{
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
        } catch{
            print("DEBUG: Failed to log in. Error \(error.localizedDescription)")
        }
    }
    
    // MARK: - SIGN UP FUNC
    @MainActor
    func createUser(withEmail email: String, password: String, fullname: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(uid: result.user.uid, fullname: fullname, email: email)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchUser()
        } catch {
            print("Error \(error.localizedDescription)")
        }
    }
    
    // MARK: - SIGN OUT FUNC
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
            
        } catch {
            print("DEBUG: Failed to sign out. Error \(error.localizedDescription)")
        }
    }
    
    // MARK: - FECTH USER DATA
    @MainActor
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else {return}
        self.currentUser = try?snapshot.data(as:User.self)
        
        print("DEBUG: Current user is: \(currentUser)")
    }
    
    
    
    // MARK: Biometric authentication
    
    func getBiometryType() {
        canEvaluatePolicy = context.canEvaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            error: nil)
        biometryType = context.biometryType
        print("\(biometryType)")
    }
    
    
    func authenticateWithBiometric() async {
        print("Starting biometric")
        context = LAContext()
        
        print("Biometric available: \(canEvaluatePolicy)")
        if canEvaluatePolicy {
            let reason = "Log into saved Account"
            
            do {
                let success = try await context.evaluatePolicy(
                    .deviceOwnerAuthenticationWithBiometrics,
                    localizedReason: reason)
                if success {
                    DispatchQueue.main.async {
                        let lastEmail = self.recentSignIn.recentAccount
                        let lastPassword = self.recentSignIn.getStoredPassword()
                        Task {
                            try await self.signIn(withEmail:lastEmail!, password:lastPassword)
                        }
                    }
                }
            } catch {
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self.errorDescription = error.localizedDescription
                    self.biometryType = .none
                }
            }
        }
    }
}
