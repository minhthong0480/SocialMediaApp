//
//  Button.swift
//  SocialMediaApp
//
//  Created by Nguyen Hoang Minh Thong on 13/09/2023.
//

import SwiftUI

struct ButtonModel: View {
    var text: String
    
    var body: some View {
        Button {
            // TODO
        } label: {
            HStack{
                Text(text)
                    .fontWeight(.bold)
                Image(systemName:"arrow.forward.circle")
            }//hstack
            .foregroundColor(.white)
            .frame(width: UIScreen.main.bounds.width - 32, height: 40)
        }//label
        .background(Color(.systemBlue))
        .cornerRadius(10)
        .padding()
    }
}

struct ButtonModel_Previews: PreviewProvider {
    static var previews: some View {
        ButtonModel(text: "Log in")
    }
}
