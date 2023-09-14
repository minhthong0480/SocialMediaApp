//
//  ProfileView.swift
//  SocialMediaApp
//
//  Created by Nguyen Hoang Minh Thong on 13/09/2023.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        List{
            Section{
                HStack {
                    Text(User.mockUser.initials)
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 72, height: 72)
                        .background(Color(.systemGray))
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading, spacing: 4){
                        Text(User.mockUser.fullname)
                            .fontWeight(.semibold)
                            .padding(.top, 4)
                        
                        Text(User.mockUser.email)
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }//vstack
                }//hstact
            }//section
            
            Section("General"){
                HStack {
                    SettingRowView(imageName: "gear", title: "Version", tinColor: Color(.systemGray))
                    
                    Spacer()
                    
                    Text("1.0.0")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }//hstack
            }//section
            
            Section("Account"){
                Button{
                    print("Sign out account")
                }label:{
                    SettingRowView(imageName: "person.crop.circle.fill.badge.minus", title: "Sign Out", tinColor: .red)
                }//label
                
                Button{
                    print("Delete account")
                }label:{
                    SettingRowView(imageName: "person.crop.circle.fill.badge.xmark", title: "Delete Account", tinColor: .red)
                }//label
                
            }//list
        }//list
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
