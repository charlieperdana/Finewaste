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
                    Text("Ali Abdul")
                        .font(Fonts.poppinsHeadline())
                    FinewasteSmallCirclePicture(fromUrl: "https://s3.amazonaws.com/www-inside-design/uploads/2020/10/aspect-ratios-blogpost-1x1-1.png")
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
        ChatDetailNavigationBar()
    }
}
