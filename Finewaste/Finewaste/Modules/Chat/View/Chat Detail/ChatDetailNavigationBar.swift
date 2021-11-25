//
//  ChatDetailNavigationBar.swift
//  Finewaste
//
//  Created by Andrean Lay on 24/11/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct ChatDetailNavigationBar: View {
    @Environment(\.presentationMode) var presentationMode
    
    private var displayName: String
    private var photoUrl: String
    
    init(displayName: String, photoUrl: String) {
        self.displayName = displayName
        self.photoUrl = photoUrl
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Button {
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .font(.system(size: 23).weight(.medium))
                    .foregroundColor(Colors.Turqoise)
                    .padding()
            }
            
            HStack {
                Spacer()
                VStack(spacing: 8) {
                    Text(displayName)
                        .font(Fonts.poppinsHeadline())
                    FinewasteSmallCirclePicture(fromUrl: photoUrl)
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Colors.Separator)
                }
                Spacer()
            }
        }
    }
}

struct ChatDetailNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        ChatDetailNavigationBar(displayName: "", photoUrl: "")
    }
}
