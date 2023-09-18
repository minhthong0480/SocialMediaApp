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
    let defaultImage = UIImage(systemName: "person")!
    @StateObject var viewModel = ProfileViewModel()
    @State private var showImagePicker = false
    
    func loadImage() {
        guard let selectedImage = selectedImage else {return}
        profileImage = Image(uiImage: selectedImage)
    }
    
    var body: some View {
        VStack {
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
                }else {
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
                    viewAuthModel.uploadProfileImage(selectedImage)
                } label: {
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
}

struct ProfileSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSelectorView()
    }
}
