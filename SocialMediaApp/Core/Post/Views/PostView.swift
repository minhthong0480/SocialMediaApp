//
//  PostView.swift
//  SocialMediaApp
//
//  Created by Hoang Hung on 14/09/2023.
//

import SwiftUI
//import UIKit

struct PostView: View {
    @ObservedObject var viewModel: PostViewModel
    private var options = ["Edit", "Delete"]
    @State private var selection = ""
    
    @State private var showEditPost = false
    @Environment(\.dismiss) var dismiss
    @State private var edittingCaption = ""
    @State private var placeholder = "What's on your mind?"
    
    init (post: Post) {
        self.viewModel = PostViewModel(post: post)
    }
    
    var body: some View {
        VStack(alignment:.leading) {
            HStack(alignment:.top, spacing: 10){
                Image(systemName: "person")
                    .resizable()
                //.scaledToFill()
                //.clipShape(Circle())
                    .frame(width:45, height:45)
                //.border(.black)
                VStack(alignment:.leading, spacing: 5){
                    Text("Kiet Duong")
                        .font(.headline)
                        .fontWeight(.bold)
                    Text("@duonganhkiet")
                        .font(.caption)
                }
                Spacer()
                VStack(alignment:.trailing, spacing: 10) {
                    Menu {
                        Button("Edit") { showEditPost.toggle() }
                        Button("Delete") { viewModel.deletePost() }
                    } label: {
                        Label("", systemImage: "ellipsis")
                    }
                    Text(viewModel.post.timestamp.formatted(date: .abbreviated, time: .shortened))
                        .font(.caption)
                    //                    Text("\(viewModel.post.timestamp)")
                    //                    Text(viewModel.post.timestamp, style: .date)
                    //                        .font(.caption)
                    //                    Text(viewModel.post.timestamp, style: .time)
                    //                        .font(.caption)
                }
            }
            Text(viewModel.post.caption)
            
            RoundedRectangle(cornerRadius: 20)
                .stroke(.black, lineWidth: 1)
                .frame(height:400)
            
            Divider()
            
            HStack(spacing:15){
                Image(systemName: "heart")
                    .resizable()
                    .scaledToFit()
                Image(systemName: "message")
                    .resizable()
                    .scaledToFit()
                Image(systemName: "arrowshape.turn.up.forward")
                    .resizable()
                    .scaledToFit()
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
                    Image(systemName: "person")
                        .resizable()
                        .clipShape(Circle())
                        .frame(width:100, height:100)
                    
                    VStack(alignment: .leading){
                        Text("Kiet Duong")
                            .font(.title)
                            .fontWeight(.bold)
                        Text("@duonganhkiet")
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
            }
        }// sheet
            
    }
}

//struct PostView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostView(post: Post(caption: "Hello, this is an example"))
//    }
//}
