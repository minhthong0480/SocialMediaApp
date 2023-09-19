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
    private var tempUser: FirebaseAuth.User?
    @Published var didAuthenticateUser = false
    @Published var user: User
    
    private(set) var context = LAContext()
    private(set) var canEvaluatePolicy = false
    @Published private(set) var biometryType: LABiometryType = .none
    @Published private(set) var errorDescription: String?
    @Published var showAlert = false
    
    init() {
        self.recentSignIn = RecentSignIn() // Initialize recentSignIn
        self.userSession = Auth.auth().currentUser
        self.didAuthenticateUser = false
        self.user = User(uid: "", fullname: "", email: "") // Replace "" with default values
        
        self.getBiometryType()
        
        Task {
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
//    @MainActor
//    func createUser(withEmail email: String, password: String, fullname: String) async throws {
//        do {
//            let result = try await Auth.auth().createUser(withEmail: email, password: password)
//            self.tempUser = result.user
////            let data = User(uid: result.user.uid, fullname: fullname, email: email)
//                        let data = ["email": email,
//                                    "fullname": fullname,
//                                    "uid": result.user.uid]
//            let encodedUser = try Firestore.Encoder().encode(data)
//            try await Firestore.firestore().collection("users").document(result.user.uid).setData(encodedUser) { _ in
//                self.didAuthenticateUser = true
//            }
//
//            await fetchUser()
//        } catch {
//            print("Error \(error.localizedDescription)")
//        }
//    }
    
    @MainActor
    func createUser(withEmail email: String, password: String, fullname: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            var user = User(uid: result.user.uid, fullname: fullname, email: email)
            
            // Set the profile image URL to nil when creating a new user
            user.profileImageUrl = nil
            
            // Update currentUser property
            self.currentUser = user
            
            // Update userSession and tempUser
//            self.userSession = result.user
            self.tempUser = result.user
            
            // Encode user data
            let encodedUser = try Firestore.Encoder().encode(user)
            
            // Save user data to Firestore
            try await Firestore.firestore().collection("users").document(result.user.uid).setData(encodedUser) { _ in
                self.didAuthenticateUser = true
            }

            // Fetch user data again to ensure it's up to date
            await fetchUser()
        } catch {
            print("Error \(error.localizedDescription)")
        }
    }
    
    
    // MARK: - UPDATE USER DATA
    func updateUser(fullname: String, profileImageUrl: String?) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        var data: [String: Any] = ["fullname": fullname]
        
        if let profileImageUrl = profileImageUrl {
            data["profileImageUrl"] = profileImageUrl
        }
        
        try await Firestore.firestore().collection("users")
            .document(uid)
            .setData(data, merge: true)
        
        // Update the currentUser object if needed
        currentUser?.fullname = fullname
        currentUser?.profileImageUrl = profileImageUrl
        
        // You can also update the userSession here if needed
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
    
    //MARK: - UPLOAD IMAGE
//    func uploadProfileImage(_ image: UIImage) {
//        guard let uid = tempUser?.uid else { return }
//
//        ImageUploader.uploadImage(image: image) { profileImageUrl in
//            // Update the profile image URL in the user object
//            self.currentUser?.profileImageUrl = profileImageUrl
//
//            // Update the user data in Firestore with the new profile image URL
//            Firestore.firestore().collection("users")
//                .document(uid)
//                .updateData(["profileImageUrl": profileImageUrl]) { _ in
//                    self.userSession = self.tempUser
//                }
//        }
//    }
    func uploadProfileImage(_ image: UIImage, completion: @escaping (String?) -> Void) {
        guard let uid = tempUser?.uid else {
            completion(nil)
            return
        }

        ImageUploader.uploadImage(image: image) { profileImageUrl in
            // Update the profile image URL in the user object
            self.currentUser?.profileImageUrl = profileImageUrl

            // Update the user data in Firestore with the new profile image URL
            Firestore.firestore().collection("users")
                .document(uid)
                .updateData(["profileImageUrl": profileImageUrl]) { error in
                    if let error = error {
                        print("Error updating profile image URL: \(error.localizedDescription)")
                        completion(nil)
                    } else {
                        self.userSession = self.tempUser
                        completion(profileImageUrl)
                    }
                }
        }
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
