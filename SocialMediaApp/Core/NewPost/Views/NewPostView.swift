/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Duong Anh Kiet
  ID: s3891487
  Created  date: 14/09/2023
  Last modified: 22/09/2023
  Acknowledgement:
    https://firebase.google.com/docs/firestore/query-data/listen
    https://firebase.google.com/docs/database/ios/read-and-write
    https://www.hackingwithswift.com/example-code/system/how-to-convert-dates-and-times-to-a-string-using-dateformatter
    https://github.com/TomHuynhSG/Movie-List-Firestore-iOS-Firebase
*/

//
//  NewPostView.swift
//  SocialMediaApp
//
//  Created by Duong Anh Kiet on 14/09/2023.
//

import SwiftUI
import PhotosUI
import Kingfisher

struct NewPostView: View {
    @ObservedObject var viewModel = NewPostViewModel()
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var caption = ""
    @State private var placeholder = "What's on your mind?"
    @State private var showingAlert = false
    @State private var message = ""
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 20) {
                if let user = authViewModel.currentUser {
                    if let imageUrlString = user.profileImageUrl, let imageUrl = URL(string: imageUrlString) {
                        KFImage(imageUrl)
                        .resizable()
                        .clipShape(Circle())
                        .frame(width:100, height:100)
                               }
                    VStack(alignment: .leading){
                        Text(user.fullname)
                            .font(.title)
                            .fontWeight(.bold)
                        Text(user.email)
                    }
                }
            }
            
            ZStack {
                if self.caption.isEmpty {
                    TextEditor(text: $placeholder)
                        .foregroundStyle(.secondary)
                        .disabled(true)
                        .padding()
                        .overlay {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(.black, lineWidth: 1)
                        }
                }
                TextEditor(text: $caption)
                    .foregroundStyle(.primary)
                    .opacity(self.caption.isEmpty ? 0.25 : 1)
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.black, lineWidth: 1)
                    }
            }
            Divider()
            HStack(spacing:15) {
                Spacer()
                Button {
                    if (self.caption != "") {
                        if let user = authViewModel.currentUser {
                            viewModel.addNewPost(caption: caption, currentUserId: user.uid ?? "Unknown" )
                            self.caption = ""
                            self.message = "New post uploaded"
                            self.showingAlert.toggle()
                        } else {
                            self.message = "Invalid user!"
                        }
                        
                    } else {
                        self.message = "Caption cannot be empty"
                        self.showingAlert.toggle()
                    }
                    
                } label: {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.black)
                        .overlay {
                            HStack {
                                Text("Post")
                                    .foregroundColor(.white)
                            }
                        }
                        .frame(width: 100, height: 40)
                }
            }
            .frame(height:40)
            Spacer()
        } //VStack
        .padding()
        .alert(message, isPresented: $showingAlert) {
            Button("OK", role: .cancel) { }
        }
    }
    
}

//struct NewPostView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewPostView()
//            .environmentObject(AuthViewModel())
//    }
//}
