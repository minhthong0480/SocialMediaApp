//
//  LoginView.swift
//  SocialMediaApp
//
//  Created by Nguyen Hoang Minh Thong on 13/09/2023.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationStack{
            VStack{
                Color.gray
                    .edgesIgnoringSafeArea(.top)
                    .frame(height: 200)
                    
                //image
                Image(systemName:"person.crop.circle.badge.checkmark")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 120)
                    .padding(.bottom, -100)
                    .edgesIgnoringSafeArea(.all)
                    .offset(y: -80)
                
                //form
                VStack(spacing: 24){
                    InputField(text: $email, title: "Email Address", placeholder: "email@example.com")
                        .autocapitalization(.none)
                    
                    InputField(text: $password, title: "Password", placeholder: "Enter your Password", isSecure: true)
                }//vstack
                .padding(.horizontal)
                .padding(.top, 12)
                
                
                //sign in button
                Button {
                    Task{
                        viewModel.signIn(withEmail: email, password: password)
                    }
                } label: {
                    HStack{
                        Text("LOG IN")
                            .fontWeight(.bold)
                        Image(systemName:"arrow.forward.circle")
                    }//hstack
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 40)
                }//label
                .modifier(ButtonModifier())
                
                Spacer()
                
                //register button
                
                NavigationLink{
                    SignupView()
                        .navigationBarBackButtonHidden()
                }label: {
                    Text("Don't have an account?")
                    Text("Sign Up")
                        .fontWeight(.bold)
                }//label
            }//Vstack
        }//navigationstack
        
    }//View
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
