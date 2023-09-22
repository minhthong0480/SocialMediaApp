/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Nguyen Hoang Minh Thong
  ID: s3852882
  Created  date: 19/9/2023
  Last modified: 22/09/2023
  Acknowledgement:
  - https://www.youtube.com/watch?v=7UKUCZuaVlA&t=16202s
  - https://www.youtube.com/watch?v=WehPyIuSlKg
  - https://www.youtube.com/watch?v=xhOFZyJW_1c
  - https://www.youtube.com/watch?v=NvcSgCKLX_0&t=596s
  - https://www.youtube.com/watch?v=3pIXMwvJLZs
*/

//
//  EditProfileView.swift
//  SocialMediaApp
//
//  Created by Nguyen Hoang Minh Thong on 19/09/2023.
//

import SwiftUI

struct EditProfileView: View {
    @Environment(\.dismiss) var dismiss
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var profileImage: Image?
    @State var fullname = ""
   
    @EnvironmentObject var viewAuthModel: AuthViewModel
    
    
    
    func loadImage() {
        guard let selectedImage = selectedImage else {return}
        profileImage = Image(uiImage: selectedImage)
    }
    
//    func updateProfile() async {
//            do {
//                let imageUrl = await viewAuthModel.uploadProfileImage(selectedImage)
//                // Update the user's profile information
//                try await viewAuthModel.updateUser(fullname: fullname, profileImageUrl: imageUrl)
//                // Dismiss the EditProfileView after updating
//                dismiss()
//            } catch {
//                // Handle any errors here
//                print("Error updating profile: \(error.localizedDescription)")
//            }
//        }
    
    var body: some View {
        VStack{
            //toolbar
            VStack {
                HStack{
                    Button("Cancel"){
                        dismiss()
                    }
                    Spacer()
                    
                    Text("Edit Profile")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Button {
                        if let selectedImage = selectedImage {
                            viewAuthModel.uploadProfileImage(selectedImage) { profileImageUrl in
                                if let profileImageUrl = profileImageUrl {
                                    // Profile image upload successful, now update the user's profile
                                    Task {
                                        do {
                                            try await viewAuthModel.updateUser(fullname: fullname, profileImageUrl: profileImageUrl)
                                            dismiss()
                                        } catch {
                                            // Handle any errors here
                                            print("Error updating profile: \(error.localizedDescription)")
                                        }
                                    }
                                } else {
                                    // Handle the case where profile image upload failed
                                    print("Error uploading profile image")
                                }
                            }
                        } else {
                            // Handle the case where no image is selected
                            Task {
                                do {
                                    try await viewAuthModel.updateUser(fullname: fullname, profileImageUrl: nil)
                                    dismiss()
                                } catch {
                                    // Handle any errors here
                                    print("Error updating profile: \(error.localizedDescription)")
                                }
                            }
                        }
                    } label: {
                        Text("Done")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                    }


                }
                .padding()
                Divider()
            }
            
            Button{
                showImagePicker.toggle()
            }label: {
                VStack{
                    if let profileImage = profileImage {
                        profileImage
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 120)
                            .foregroundColor(Color(.black))
                            .padding()
                            .clipShape(Circle())
                    } else {
                        Image(systemName: "person")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50, height: 60)
                            .foregroundColor(Color(.black))
                            .padding()
                            .background(.gray)
                            .clipShape(Circle())
                    }
                    Text("Choose Picture")
                        .fontWeight(.semibold)
                    Divider()
                }
                .padding(.vertical, 10)
                
                
            }
            .sheet(isPresented: $showImagePicker, onDismiss: loadImage){
                ImagePicker(selectedImage: $selectedImage)
                
            }
            VStack{
                EditProfileRowView(title: "FullName", placeholder: "Enter your new name", text: $fullname)
            }
            Spacer()
        }
    }
}

struct EditProfileRowView: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        HStack{
            Text(title)
                .padding(.leading, 8)
                .frame(width: 100, alignment: .leading)
            
            VStack{
                TextField(placeholder, text:  $text)
                
                Divider()
            }
        }
        .font(.subheadline)
        .frame(height: 36)
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
