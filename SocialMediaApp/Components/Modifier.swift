//
//  Modifier.swift
//  SocialMediaApp
//
//  Created by Nguyen Hoang Minh Thong on 13/09/2023.
//

import Foundation
import SwiftUI

struct ButtonModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .background(Color(.systemBlue))
            .cornerRadius(10)
            .padding()
    }
}
