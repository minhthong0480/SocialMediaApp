//
//  NewPostView.swift
//  SocialMediaApp
//
//  Created by Duong Anh Kiet on 14/09/2023.
//

import SwiftUI

struct NewPostView: View {
    @ObservedObject var viewModel = NewPostViewModel()
    @State private var caption = ""
    @State private var placeholder = "What's on your mind?"
    var body: some View {
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
                    viewModel.addNewPost(caption: caption)
                    self.caption = ""
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
        //        .frame(width: UIScreen.main.bounds.width - 40)
    }
    
}

struct NewPostView_Previews: PreviewProvider {
    static var previews: some View {
        NewPostView()
    }
}
