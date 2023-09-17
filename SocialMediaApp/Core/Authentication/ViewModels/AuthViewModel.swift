//
//  AuthViewModel.swift
//  SocialMediaApp
//
//  Created by Nguyen Hoang Minh Thong on 15/09/2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestoreSwift
import FirebaseFirestore
import Firebase

protocol AuthFormProtocol {
    var validForm: Bool {get}
}


class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init(){
        self.userSession = Auth.auth().currentUser
        
        Task{
            await fetchUser()
        }
    }
    
    @MainActor
    func signIn(withEmail email: String, password: String) async throws {
        do{
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
        } catch{
            print("DEBUG: Fialed to log in. Error \(error.localizedDescription)")
        }
    }
    
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
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
        } catch {
            print("DEBUG: Fialed to sign out. Error \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else {return}
        self.currentUser = try?snapshot.data(as:User.self)
        
        print("DEBUG: Current user is: \(self.currentUser)")
    }
    
    private func uploadUserData(email: String, fullname: String, id: String) async throws {
        let user = User(fullname: fullname, email: email, profileImageUrl: nil)
        guard let encodeUser = try? Firestore.Encoder().encode(user) else { return }
        try await Firestore.firestore().collection("user").document(id).setData(encodeUser)
    }
}
