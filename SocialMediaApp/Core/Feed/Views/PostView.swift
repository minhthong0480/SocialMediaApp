//
//  PostView.swift
//  SocialMediaApp
//
//  Created by Hoang Hung on 14/09/2023.
//

import SwiftUI
import UIKit

struct PostView: View {
    var body: some View {
        VStack(alignment:.leading){
            HStack(alignment:.top, spacing: 10){
                Image(systemName: "person")
                    .resizable()
                    //.scaledToFill()
                    //.clipShape(Circle())
                    .frame(width:45, height:45)
                    //.border(.black)
                VStack(alignment:.leading){
                    Text("John Doe")
                        .font(.headline)
                        .fontWeight(.bold)
                    Text("@johndoe")
                        .font(.caption)
                }
                Spacer()
                Text("Just now")
                    .font(.caption)
            }
            Text("This is an example caption.")
            Rectangle()
                .frame(height:400)
                .cornerRadius(20)
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
        }
        .frame(width: UIScreen.main.bounds.width - 40)
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
    }
}
