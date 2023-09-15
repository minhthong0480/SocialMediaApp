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
                RoundedRectangle(cornerRadius: 50)
                    .frame(width: 1000, height: 300)
                    .ignoresSafeArea()
                    .foregroundStyle(.linearGradient(colors: [.indigo, .red], startPoint: .topLeading, endPoint: .bottomTrailing))
                
                Text("Sign Up")
                    .offset(x:-100, y:-200)
                    .foregroundColor(.white)
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                
                Image(systemName:"person.crop.circle.badge.questionmark")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 120)
                    .padding(.bottom, -300)
                    .edgesIgnoringSafeArea(.all)
                    .offset(y: -210)
                
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
                        try await viewModel.signIn(withEmail: email, password: password)
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
