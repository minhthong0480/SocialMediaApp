//
//  Dropdown.swift
//  SocialMediaApp
//
//  Created by Duy Nguyen Hieu Duc on 15/09/2023.
//

import SwiftUI

struct Dropdown: View {
    @State private var selection = "Red"
    let colors = ["Red", "Green", "Blue", "Black", "Tartan"]
    
    var body: some View {
        HStack {
            
            
            // Button, that when tapped shows 3 options
            Menu {
                Button{
                    print("Sign out")
                }label:{
                    SettingRowView(imageName: "person.crop.circle.fill.badge.minus", title: "Sign Out", tinColor: .red)
                }//label
                Button{
                    print("Delete account")
                }label:{
                    SettingRowView(imageName: "person.crop.circle.fill.badge.xmark", title: "Delete Account", tinColor: .red)
                }//label
            } label: {
                Image(systemName: "line.3.horizontal")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.gray)
                    .frame(width: 30, height: 50)
                    
            }
        }
    }
}

struct Dropdown_Previews: PreviewProvider {
    static var previews: some View {
        Dropdown()
    }
}
