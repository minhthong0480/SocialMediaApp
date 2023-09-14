//
//  NewPostView.swift
//  SocialMediaApp
//
//  Created by Duong Anh Kiet on 14/09/2023.
//

import SwiftUI

struct NewPostView: View {
    @State private var caption = ""
    var body: some View {
        VStack() {
            VStack(spacing: 10){
                Image(systemName: "person")
                    .resizable()
                //                .scaledToFill()
                    .clipShape(Circle())
                    .frame(width:150, height:150)
                //                .border(.black)
                VStack(){
                    Text("John Doe")
                        .font(.headline)
                        .fontWeight(.bold)
                    Text("@johndoe")
                        .font(.caption)
                }
            }
            TextEditor(text: $caption)
                .foregroundStyle(.primary)
                .padding()
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.black, lineWidth: 1)
                }
            Divider()
            HStack(spacing:15) {
                Spacer()
                Button {
                    
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
