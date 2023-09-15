//
//  ProfileView.swift
//  SocialMediaApp
//
//  Created by Nguyen Hoang Minh Thong on 13/09/2023.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        if let user = viewModel.currentUser {
            ScrollView {
                ZStack{
                    VStack{
                        HStack {
                            Circle()
                                .stroke(.blue, lineWidth:2)
                                .frame(width: 200)
                                .padding(.leading,20)
                                .overlay(
                                    Image("profileAvatar")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 130, height: 130)
                                        .padding(.leading,20)
                            )
                            Spacer()
                            Dropdown()
                                .padding(.trailing, 15)
                                .padding(.top, -80)
                                
                                
                        }
                        Image(systemName: "gearshape.fill")
                            .font(.system(size: 26))
                            .foregroundColor(.gray)
                            .offset(x: -15, y: -30)
                        
                        Text(user.fullname)
                            .fontWeight(.semibold)
                            .padding(.top, -30)
                            .offset(x: -95, y: 0)
                        
                        Text(user.email)
                            .font(.footnote)
                            .foregroundColor(.gray)
                            .padding(.top, -20)
                            .offset(x: -95, y: 0)
                        
                        HStack {
                            Section("Bio"){
                                SectionBar(length: 270)
                                Image(systemName: "pencil")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 20))
                            }// Section
                            .font(.system(size: 30))
                            .foregroundColor(.gray)
                            .padding(.trailing, 10)
                            
                        }// Hstack
                        VStack{
                            Text("DOB: ")
                            Text("Gender: ")
                            Text("Currrently Works at:")
                            Text("blah blah")
                        }// VStack
                        
                        HStack {
                            Section("Posts"){
                                SectionBar(length: 260)
                            }
                            Image(systemName: "plus")
                                .font(.system(size: 20))
                        }// HStack
                        .font(.system(size: 30))
                        .foregroundColor(.gray)
                        
                        
                        HStack {
                            ThumbnailView()
                            ThumbnailView()
                            
                            
                        }// HStack
                        HStack {
                            ThumbnailView()
                            ThumbnailView()
                            
                        }// HStack
                        HStack {
                            ThumbnailView()
                            ThumbnailView()
                            
                        }// HStack
                        
                        
                        
                    }// Vstack
                    
                }//ZStack
            }// ScrollView
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
