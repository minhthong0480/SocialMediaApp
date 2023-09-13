//
//  InputField.swift
//  SocialMediaApp
//
//  Created by Nguyen Hoang Minh Thong on 13/09/2023.
//

import SwiftUI

struct InputField: View {
    @Binding var text: String
    let title: String
    let placeholder: String
    var isSecure = false
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            Text(title)
                .foregroundColor(Color(.darkGray))
                .fontWeight(.bold)
                .font(.footnote)
            
            if isSecure{
                SecureField(placeholder, text: $text)
                    .font(.system(size: 14))
            } else {
                TextField(placeholder, text: $text)
                    .font(.system(size: 14))
            }
            Divider()
        }
    }
}

struct InputField_Previews: PreviewProvider {
    static var previews: some View {
        InputField(text: .constant(""), title: "Email Address", placeholder: "email@example.com" )
    }
}
