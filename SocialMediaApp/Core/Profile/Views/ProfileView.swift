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
        //        List{
        //            Section{
        //                HStack {
        //                    Text(User.mockUser.initials)
        //                        .font(.title)
        //                        .fontWeight(.semibold)
        //                        .foregroundColor(.white)
        //                        .frame(width: 72, height: 72)
        //                        .background(Color(.systemGray))
        //                        .clipShape(Circle())
        //
        //                    VStack(alignment: .leading, spacing: 4){
        //                        Text(User.mockUser.fullname)
        //                            .fontWeight(.semibold)
        //                            .padding(.top, 4)
        //
        //                        Text(User.mockUser.email)
        //                            .font(.footnote)
        //                            .foregroundColor(.gray)
        //                    }//vstack
        //                }//hstact
        //            }//section
        //
        //            Section("General"){
        //                HStack {
        //                    SettingRowView(imageName: "gear", title: "Version", tinColor: Color(.systemGray))
        //
        //                    Spacer()
        //
        //                    Text("1.0.0")
        //                        .font(.subheadline)
        //                        .foregroundColor(.gray)
        //                }//hstack
        //            }//section
        //
        //            Section("Account"){
        //                Button{
        //                    print("Sign out account")
        //                }label:{
        //                    SettingRowView(imageName: "person.crop.circle.fill.badge.minus", title: "Sign Out", tinColor: .red)
        //                }//label
        //
        //                Button{
        //                    print("Delete account")
        //                }label:{
        //                    SettingRowView(imageName: "person.crop.circle.fill.badge.xmark", title: "Delete Account", tinColor: .red)
        //                }//label
        //
        //            }//list
        //        }//list
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
                    
                    Text(User.mockUser.fullname)
                        .fontWeight(.semibold)
                        .padding(.top, -30)
                        .offset(x: -95, y: 0)
                    
                    Text(User.mockUser.email)
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

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
