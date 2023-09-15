//
//  ThumbnailView.swift
//  SocialMediaApp
//
//  Created by Duy Nguyen Hieu Duc on 15/09/2023.
//

import SwiftUI

struct ThumbnailView: View {
    var body: some View {
        Image("sample")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 200,height: 250)
            .padding(.horizontal,-20)
            .shadow(color: .black.opacity(0.5), radius: 10)
            .offset(x: -0, y: 20)
    }
}

struct ThumbnailView_Previews: PreviewProvider {
    static var previews: some View {
        HStack{
            ThumbnailView()
            ThumbnailView()
        }
    }
}
