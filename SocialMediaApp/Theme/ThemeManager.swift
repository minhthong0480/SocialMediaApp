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
    
    private init() {}
    
    func handleTheme(darkMode: Bool) {
        UIApplication.shared.windows.first?.overrideUserInterfaceStyle = darkMode ? .dark : .light
    }
}
