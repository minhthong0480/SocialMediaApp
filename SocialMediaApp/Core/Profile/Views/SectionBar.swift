//
//  SectionBar.swift
//  SocialMediaApp
//
//  Created by Duy Nguyen Hieu Duc on 15/09/2023.
//

import SwiftUI

struct SectionBar: View {
    @State var length: CGFloat
    var body: some View {
        
        Rectangle()
            .frame(width: length, height: 1)
            .foregroundColor(.gray)
            .padding(.leading, 22)
            .padding(.trailing, 12)
    }
}

struct SectionBar_Previews: PreviewProvider {
    static var previews: some View {
        SectionBar(length:200)
    }
}
