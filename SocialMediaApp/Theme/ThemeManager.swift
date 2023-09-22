/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Ngo Chi Binh
  ID: s3938145
  Created  date: 20/09/2023
  Last modified: 22/09/2023
  Acknowledgement:
    https://www.youtube.com/watch?v=j7a4jvHz4MM&t=878s
*/

//
//  ThemeManager.swift
//  SocialMediaApp
//
//  Created by Binh Ngo on 20/09/2023.
//

import Foundation
import UIKit

class ThemeManager {
    
    static let shared = ThemeManager()
    
    private  init() {}
    
    func handleTheme(darkMode: Bool) {
        UIApplication.shared.windows.first?.overrideUserInterfaceStyle = darkMode ? .dark : .light
    }
}
