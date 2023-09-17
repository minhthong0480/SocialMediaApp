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
    @EnvironmentObject var viewModel: AuthViewModel
    @State var signUpSuccess = false
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        //image
        NavigationStack {
            VStack {
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
                    
                    InputField(text: $fullname, title: "Full Name", placeholder: "Enter Your Full Name")
                        .autocapitalization(.none)
                    
                    InputField(text: $password, title: "Password", placeholder: "Enter your Password", isSecure: true)
                    
                    ZStack(alignment: .trailing){
                        InputField(text: $confirmPassword, title: "Confirm Password", placeholder: "Confirm your Password", isSecure: true)
                        if !password.isEmpty && !confirmPassword.isEmpty {
                            if password == confirmPassword {
                                Image(systemName:"checkmark.circle")
                                    .foregroundColor(.green)
                                    .imageScale(.large)
                                    .fontWeight(.bold)
                            } else {
                                Image(systemName:"xmark.circle")
                                    .foregroundColor(.red)
                                    .imageScale(.large)
                                    .fontWeight(.bold)
                            }
                        }
                    }
                }//vstack
                .padding(.horizontal)
                .padding(.top, 12)
                
                //submit button
                Button {
                    Task{
                        try await viewModel.createUser(withEmail: email, password: password, fullname: fullname)
                    }
                } label: {
                    HStack{
                        Text("SIGN UP")
                            .fontWeight(.bold)
                        Image(systemName:"arrow.forward.circle")
                    }//hstack
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 40)
                }//label
                .modifier(ButtonModifier())
                
                Spacer()
                
                NavigationLink{
                    LoginView(recentSignIn: RecentSignIn())
                        .navigationBarBackButtonHidden(true)
                    
                }label: {
                    Text("Already have an account? ")
                    Text("Log In")
                        .fontWeight(.bold)
                }//label
                
            }
        }//Vstack
        
    }//View
}
extension SignupView: AuthFormProtocol {
    var validForm: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
        && !fullname.isEmpty
        && confirmPassword == password
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
