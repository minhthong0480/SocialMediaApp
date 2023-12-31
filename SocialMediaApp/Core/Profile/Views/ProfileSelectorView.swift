/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Nguyen Hieu Duc Duy
  ID: s3930426
  Created  date: 18/9/2023
  Last modified: 22/09/2023
  Acknowledgement:
  - https://www.youtube.com/watch?v=7UKUCZuaVlA&t=16202s
  - https://www.youtube.com/watch?v=WehPyIuSlKg
  - https://www.youtube.com/watch?v=xhOFZyJW_1c
  - https://www.youtube.com/watch?v=NvcSgCKLX_0&t=596s
  - https://www.youtube.com/watch?v=3pIXMwvJLZs
*/

//
//  ProfileSelectorView.swift
//  SocialMediaApp
//
//  Created by Nguyen Hoang Minh Thong on 18/09/2023.
//

import SwiftUI
import PhotosUI

struct ProfileSelectorView: View {
    @EnvironmentObject var viewAuthModel: AuthViewModel
    @State private var selectedImage: UIImage?
    @State private var profileImage: Image?
    @StateObject var viewModel = ProfileViewModel()
    @State private var showImagePicker = false
    @State private var isUploading = false
    
    func loadImage() {
        guard let selectedImage = selectedImage else {return}
        profileImage = Image(uiImage: selectedImage)
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    LinearGradient(
                        gradient: Gradient(colors: [.indigo, .red]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .frame(height: geometry.size.height * 0.3) // Adjust the fraction for desired height
                    .ignoresSafeArea()
                    
                    Text("Choose Profile\n Picture")
                        .offset(x:-50, y:-200)
                        .foregroundColor(.white)
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                    
                    Button{
                        showImagePicker.toggle()
                    }label: {
                        if let profileImage = profileImage {
                            profileImage
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 120)
                                .foregroundColor(Color(.black))
                                .padding()
                                .clipShape(Circle())
                        } else {
                            Image(systemName: "person.crop.circle.badge.plus")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 120)
                                .foregroundColor(Color(.black))
                                .padding()
                            
                        }
                    }
                    .sheet(isPresented: $showImagePicker, onDismiss: loadImage){
                        ImagePicker(selectedImage: $selectedImage)
                    }
                    
                    if let selectedImage = selectedImage {
                        Button {
                            // Start uploading image
                            isUploading = true
                            
                            viewAuthModel.uploadProfileImage(selectedImage) { success in
                                // Handle upload completion
                                isUploading = false
                                
                                if success != nil {
                                    // Successfully uploaded image
                                    // You can add any further actions here
                                    print("Image upload successful!")
                                } else {
                                    // Handle upload failure
                                    print("Image upload failed.")
                                }
                            }
                        }label: {
                            HStack{
                                Text("Finish")
                                    .fontWeight(.bold)
                                Image(systemName:"arrow.forward.circle")
                            }//hstack
                            .foregroundColor(.white)
                            .frame(width: UIScreen.main.bounds.width - 32, height: 40)
                        }//label
                        .modifier(ButtonModifier())
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
        }
        
        
    }
}

struct ProfileSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSelectorView()
    }
}
