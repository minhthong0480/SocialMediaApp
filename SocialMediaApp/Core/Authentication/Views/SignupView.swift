//
//  SignupViews.swift
//  SocialMediaApp
//
//  Created by Nguyen Hoang Minh Thong on 13/09/2023.
//

import SwiftUI

struct SignupView: View {
    @State private var email = ""
    @State private var fullname = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        //image
        VStack {
            Image(systemName:"person.crop.circle.badge.questionmark")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 120)
                .padding(.vertical, 32)
            
            //form
            VStack(spacing: 24){
                InputField(text: $email, title: "Email Address", placeholder: "email@example.com")
                    .autocapitalization(.none)
                
                InputField(text: $fullname, title: "Full Name", placeholder: "Enter Your Full Name")
                    .autocapitalization(.none)
                
                InputField(text: $password, title: "Password", placeholder: "Enter your Password", isSecure: true)
                
                InputField(text: $confirmPassword, title: "Confirm Password", placeholder: "Confirm your Password", isSecure: true)
            }//vstack
            .padding(.horizontal)
            .padding(.top, 12)
            
            //submit button
            Button {
                // TODO
            } label: {
                HStack{
                    Text("SIGN UP")
                        .fontWeight(.bold)
                    Image(systemName:"arrow.forward.circle")
                }//hstack
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 32, height: 40)
            }//label
            .background(Color(.systemBlue))
            .cornerRadius(10)
            .padding()
            
            Spacer()
            
            Button {
                dismiss
            } label: {
                HStack{
                    Text("Already have an account?")
                    Text("Log In")
                        .fontWeight(.bold)
                    
                }//hstack
                
                
            }//label
            
        }
        
    }//View
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
