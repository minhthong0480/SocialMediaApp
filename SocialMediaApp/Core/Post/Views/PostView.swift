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
                VStack(alignment:.leading){
                    Text("Kiet Duong")
                        .font(.headline)
                        .fontWeight(.bold)
                    Text("@duonganhkiet")
                        .font(.caption)
                }
                Spacer()
                VStack(alignment:.trailing) {
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
//        .frame(width: UIScreen.main.bounds.width - 40)
    }
}

//struct PostView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostView(post: Post(caption: "Hello, this is an example"))
//    }
//}
