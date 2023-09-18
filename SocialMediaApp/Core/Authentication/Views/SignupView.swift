//
//  SignupViews.swift
//  SocialMediaApp
//
//  Created by Nguyen Hoang Minh Thong on 13/09/2023.
//

import SwiftUI
import PhotosUI

struct SignupView: View {
    @State private var email = ""
    @State private var fullname = ""
    @State private var selectedImage: UIImage?
    let defaultImage = UIImage(systemName: "person")!
    @State private var profileImage: Image?
    @State private var password = ""
    @State private var confirmPassword = ""
    @EnvironmentObject var viewAuthModel: AuthViewModel
    @StateObject var viewModel = ProfileViewModel()
    @State var signUpSuccess = false
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        //image
        NavigationStack {
            VStack {
                NavigationLink(destination: ProfileSelectorView(),isActive:$viewAuthModel.didAuthenticateUser, label: {})
                
                RoundedRectangle(cornerRadius: 50)
                    .frame(width: 1000, height: 300)
                    .ignoresSafeArea()
                    .foregroundStyle(.linearGradient(colors: [.indigo, .red], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .padding(.bottom, -150)
                
                Text("Sign Up")
                    .offset(x:-100, y:-100)
                    .foregroundColor(.white)
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                
                //MARK: - FORM
                VStack(spacing: 24){
                    //                    Image(systemName: "person.crop.circle.badge.plus")
                    //                        .resizable()
                    //                        .scaledToFill()
                    //                        .frame(width: 100, height: 120)
                    //                        .foregroundColor(Color(.black))
                    //                        .padding()
                    //                        .offset(y: -100)
                    //                        .padding(.bottom, -80)
                    
                    //                    PhotosPicker(selection: $viewModel.selectedItem){
                    //                        if let profileImage = viewModel.profileImage{
                    //                            profileImage
                    //                                .resizable()
                    //                                .scaledToFill()
                    //                                .frame(width: 100, height: 120)
                    //                                .foregroundColor(Color(.black))
                    //                                .padding()
                    //                                .clipShape(Circle())
                    //                        } else {
                    //                            Image(systemName: "person.crop.circle.badge.plus")
                    //                                .resizable()
                    //                                .scaledToFill()
                    //                                .frame(width: 100, height: 120)
                    //                                .foregroundColor(Color(.black))
                    //                                .padding()
                    //                                .offset(y: -100)
                    //                                .padding(.bottom, -80)
                    //                        }
                    //                    }
                    
                    Image(systemName: "person.crop.circle.badge.plus")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 120)
                        .foregroundColor(Color(.black))
                        .padding()
                        .offset(y: -100)
                        .padding(.bottom, -80)
                    
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
                
                //MARK: - SIGNUP BUTTON
                
                Button {
                    Task{
                        try await viewAuthModel.createUser(withEmail: email, password: password, fullname: fullname)
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
                
                //MARK: - NAVIGATION LINK TO LOGIN PAGE
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
