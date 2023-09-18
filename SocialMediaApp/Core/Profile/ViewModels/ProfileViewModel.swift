//
//  ProfileViewModel.swift
//  SocialMediaTest
//
//  Created by Nguyen Hoang Minh Thong on 16/09/2023.
//

import Foundation
import SwiftUI
import PhotosUI
import UIKit


class ProfileViewModel: ObservableObject{
    @Published var selectedItem: PhotosPickerItem? {
        didSet { Task{try await loadImage()} }
    }
    
    @Published var profileImage: Image?
    
    @MainActor
    func loadImage() async throws {
        guard let item = selectedItem else {return}
        guard let imageData = try await item.loadTransferable(type: Data.self) else {return}
        guard let uiImage = UIImage(data: imageData) else {return}
        self.profileImage = Image(uiImage: uiImage)
    }
//    func loadImage(){
//        guard let selectedImage = selectedItem else {return}
//        profileImage = Image(uiImage: selectedImage)
//    }
}
