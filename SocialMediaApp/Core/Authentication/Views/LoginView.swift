//
//  LoginView.swift
//  SocialMediaApp
//
//  Created by Nguyen Hoang Minh Thong on 13/09/2023.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var recentSignIn: RecentSignIn
    
    @State private var email = ""
    @State private var password = ""
    @State private var image = ""
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationStack{
            VStack{
                RoundedRectangle(cornerRadius: 50)
                    .frame(width: 1000, height: 300)
                    .ignoresSafeArea()
                    .foregroundStyle(.linearGradient(colors: [.indigo, .red], startPoint: .topLeading, endPoint: .bottomTrailing))
                
                Text("Log in")
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
                    InputField(text: $email, title: "Email Address", placeholder:"example@email.com")
                        .autocapitalization(.none)
                    
                    InputField(text: $password, title: "Password", placeholder: "Enter your Password", isSecure: true)
                }//vstack
                .padding(.horizontal)
                .padding(.top, 12)
                
                
                //sign in button
                VStack(spacing: 30) {
                    Button {
                        Task{
                            try await viewModel.signIn(withEmail: email, password: password)
                        }
                        recentSignIn.recentAccount = email
                        recentSignIn.updateStoredPassword(password)
                        
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
                    
                    
                    Button {
                        Task.init {
                            await viewModel.authenticateWithBiometric()
                        }
                    } label: {
                        Image(systemName: (viewModel.biometryType == .faceID) ? "faceid" : "touchid")
                            .resizable()
                            .frame(maxWidth: 60, maxHeight: 60)
                    }
                }
                
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

extension LoginView: AuthFormProtocol {
    var validForm: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(recentSignIn: RecentSignIn())
            .environmentObject(AuthViewModel())
    }
}
