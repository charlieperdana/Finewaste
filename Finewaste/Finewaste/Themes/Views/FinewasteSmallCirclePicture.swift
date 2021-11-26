//
//  FinewasteSmallCirclePicture.swift
//  Finewaste
//
//  Created by Andrean Lay on 24/11/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct FinewasteSmallCirclePicture: View {
    var url: String
    
    init(fromUrl url: String) {
        self.url = url
    }
    
    var body: some View {
        WebImage(url: URL(string: url))
            .resizable()
            .frame(width: 44, height: 44)
            .clipShape(Circle())
    }
}

struct FinewasteSmallCirclePicture_Previews: PreviewProvider {
    static var previews: some View {
        FinewasteSmallCirclePicture(fromUrl: "")
    }
}