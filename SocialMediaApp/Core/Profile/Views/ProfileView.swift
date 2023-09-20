//
//  ProfileView.swift
//  SocialMediaTest
//
//  Created by Nguyen Hoang Minh Thong on 16/09/2023.
//

import SwiftUI
import PhotosUI
import Kingfisher

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewModel()
    @EnvironmentObject var viewAuthModel: AuthViewModel
    
    @State private var showEditProfile = false
    @State private var shouldNavigateToLogin = false
    
    @Binding var darkModeEnabled: Bool
    
    enum ProfileRowViewModel: Int, CaseIterable, Identifiable{
        
        case email
        case fullname
        
        
        
        func userData(viewAuthModel: AuthViewModel) -> String {
            switch self {
            case .email: return viewAuthModel.currentUser?.email ?? ""
            case .fullname: return viewAuthModel.currentUser?.fullname ?? ""
            }
        }
        
        var title: String {
            switch self {
            case .email: return "Email"
            case .fullname: return "FullName"
            }
        }
        
        var imageName: String {
            switch self {
            case .email: return "envelope"
            case .fullname: return "person"
            
            }
        }
        
        
        var id: Int {return self.rawValue}
    }
    
    var body: some View {
        NavigationStack {
            VStack{
                if let user = viewAuthModel.currentUser {
                    if let imageUrlString = user.profileImageUrl, let imageUrl = URL(string: imageUrlString) {
                        KFImage(imageUrl)
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                            .frame(width: 100, height: 120)
                    } else {
                        // Provide a default image or placeholder when profileImageUrl is nil
                        Image("profileAvatar")
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                            .frame(width: 100, height: 120)
                    }
                    
                    //                    KFImage(URL(string: user.profileImageUrl))
                    //                        .resizable()
                    //                        .scaledToFill()
                    //                        .clipShape(Circle())
                    //                        .frame(width: 100, height: 120)
                    
                    
                    Text(user.fullname)
                        .font(.title)
                        .fontWeight(.semibold)
                    
                    
                    List{
                        Section{
                            ForEach(ProfileRowViewModel.allCases, id: \.self) { option in
                                HStack {
                                    Image(systemName: option.imageName)
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                        .foregroundColor(Color(.systemPurple))
                                    
                                    Text("\(option.title): \(option.userData(viewAuthModel: viewAuthModel))")
                                    
                                }
                            }
                        }
                        Section {
                            Toggle(isOn: $darkModeEnabled
                                   , label: {
                                Text("Dark mode")
                            })
                            .onChange(of: darkModeEnabled
                                      , perform: {_ in
                                            ThemeManager
                                                .shared
                                                .handleTheme(darkMode: darkModeEnabled)
                            })
                            
                            Button("Edit Profile"){
                                print("Edit profile button clicked")
                                showEditProfile.toggle()
                            }
                            
                            Button("Sign Out") {
                                viewAuthModel.signOut()
                            }
                        }
                        .foregroundColor(.red)
                    }
                }//if statement
                
            }//Vstack
            .fullScreenCover(isPresented: $showEditProfile) {
                EditProfileView()
            }
            
        }//Navigationstack
        
    }
    
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(darkModeEnabled: .constant(false))
            .environmentObject(AuthViewModel())
    }
}
