/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Nguyen Hoang Vinh Hung
  ID: s3911246
  Created  date: 14/09/2023
  Last modified: 22/09/2023
  Acknowledgement:
    https://firebase.google.com/docs/firestore/query-data/listen
    https://firebase.google.com/docs/database/ios/read-and-write
    https://www.hackingwithswift.com/example-code/system/how-to-convert-dates-and-times-to-a-string-using-dateformatter
    https://github.com/TomHuynhSG/Movie-List-Firestore-iOS-Firebase
*/

//
//  PostView.swift
//  SocialMediaApp
//
//  Created by Hoang Hung on 14/09/2023.
//

import SwiftUI
import Kingfisher
//import UIKit

struct PostView: View {
    @ObservedObject var viewModel: PostViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    
    private var options = ["Edit", "Delete"]
    @State private var selection = ""
    
    @State private var showEditPost = false
    @Environment(\.dismiss) var dismiss
    
    @State private var edittingCaption = ""
    @State private var placeholder = "What's on your mind?"
    
    @State private var isLiked: Bool
    
    init (post: Post) {
        self.viewModel = PostViewModel(post: post)
        _isLiked = State(initialValue: post.isLiked)
    }
    
    var body: some View {
        VStack(alignment:.leading) {
            HStack(alignment:.top, spacing: 10) {
                
                if let user = viewModel.user {
                    if let imageUrlString = user.profileImageUrl, let imageUrl = URL(string: imageUrlString) {
                        KFImage(imageUrl)
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                            .frame(width: 45, height: 45)
                    }
                } else {
                    Image(systemName: "person")
                        .resizable()
                        .frame(width:45, height:45)
                }
                
                VStack(alignment:.leading, spacing: 5){
                    if let user = viewModel.user {
                        Text(user.fullname)
                            .font(.headline)
                            .fontWeight(.bold)
                        Text(user.email)
                            .font(.caption)
                    }
                    
                }
                Spacer()
                VStack(alignment:.trailing, spacing: 10) {
                    if let currentUser = authViewModel.currentUser, let postUser = viewModel.user {
                        if currentUser.uid == postUser.uid {
                            Menu {
                                Button("Edit") { showEditPost.toggle() }
                                Button("Delete") { viewModel.deletePost() }
                            } label: {
                                Label("", systemImage: "ellipsis")
                            }
                        }
                    }
                    Text(viewModel.post.timestamp.formatted(date: .abbreviated, time: .shortened))
                        .font(.caption)
                }
            }
            Text(viewModel.post.caption)
            
            Divider()
            
            HStack(spacing:20){
                Button(action: {
                    if let currentUser = authViewModel.currentUser {
                        
                        if self.isLiked == true {
                            self.viewModel.unlikePost(userId: currentUser.uid ?? "Unknown")
                            self.isLiked = false
                        } else {
                            self.viewModel.likePost(userId: currentUser.uid ?? "Unknown")
                            self.isLiked = true
                        }
                    }
                }) {
                    Image(systemName: self.isLiked == true ? "hand.thumbsup.fill" : "hand.thumbsup")
                        .resizable()
                        .scaledToFit()
                }
                Text("\(self.viewModel.post.likes)")
                
                Spacer()
                Image(systemName: "bookmark")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25)
            }
            .frame(height:25)
        } //VStack
        .padding()
        .sheet(isPresented: $showEditPost) {
            VStack(alignment: .leading) {
                HStack(spacing: 20) {
                    if let user = viewModel.user {
                        if let imageUrlString = user.profileImageUrl, let imageUrl = URL(string: imageUrlString) {
                            KFImage(imageUrl)
                                .resizable()
                                .scaledToFill()
                                .clipShape(Circle())
                                .frame(width: 100, height: 100)
                        }
                    } else {
                        Image(systemName: "person")
                            .resizable()
                            .frame(width:100, height:100)
                    }
                    
                    VStack(alignment: .leading){
                        if let user = viewModel.user {
                            Text(user.fullname)
                                .font(.headline)
                                .fontWeight(.bold)
                            Text(user.email)
                                .font(.caption)
                        }
                    }
                }
                
                ZStack {
                    if self.edittingCaption.isEmpty {
                        TextEditor(text: $placeholder)
                            .foregroundStyle(.secondary)
                            .disabled(true)
                            .padding()
                            .overlay {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(.black, lineWidth: 1)
                            }
                    }
                    TextEditor(text: $edittingCaption)
                        .foregroundStyle(.primary)
                        .opacity(self.edittingCaption.isEmpty ? 0.25 : 1)
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
                        self.viewModel.updatePost(caption: self.edittingCaption)
                        dismiss()
                        showEditPost.toggle()
                    } label: {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.black)
                            .overlay {
                                HStack {
                                    Text("Update")
                                        .foregroundColor(.white)
                                }
                            }
                            .frame(width: 100, height: 40)
                    }
                    Button {
                        dismiss()
                        showEditPost.toggle()
                    } label: {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.black)
                            .overlay {
                                HStack {
                                    Text("Cancel")
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
            .onAppear {
                self.edittingCaption = viewModel.post.caption
//                self.isLiked = viewModel.post.isLiked
            }
        }// sheet
    }
    
}

