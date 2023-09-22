/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Nguyen Hieu Duc Duy
  ID: s3930426
  Created  date: 16/9/2023
  Last modified: 22/09/2023
  Acknowledgement:
  - https://www.youtube.com/watch?v=7UKUCZuaVlA&t=16202s
  - https://www.youtube.com/watch?v=WehPyIuSlKg
  - https://www.youtube.com/watch?v=xhOFZyJW_1c
  - https://www.youtube.com/watch?v=NvcSgCKLX_0&t=596s
  - https://www.youtube.com/watch?v=3pIXMwvJLZs
*/

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
}
