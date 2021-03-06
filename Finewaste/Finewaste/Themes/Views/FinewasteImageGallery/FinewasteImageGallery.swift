//
//  FinewasteImageGallery.swift
//  Finewaste
//
//  Created by Andrean Lay on 14/11/21.
//

import SwiftUI
import Kingfisher

enum GalleryAlignment {
    case left
    case right
}

struct FinewasteImageGallery: View {
    var images: [URL]
    var maxImagesToDisplay: Int
    var galleryTitle: String
    var alignment: GalleryAlignment
    
    var body: some View {
        HStack(spacing: 16) {
            if alignment == .right {
                Spacer()
            }
            
            ForEach(0..<maxImagesToDisplay) { index in
                NavigationLink(
                    destination: ImageGalleryView(updatePostedDate: galleryTitle, images: images, chosenIndex: index)) {
                        KFImage(images[index])
                            .placeholder {
                                Rectangle()
                                    .modifier(Shimmering(configuration: .default))
                            }
                            .centerWidthCrop(width: 100, height: 100)
                            .cornerRadius(10)
                    }
            }
            if images.count > maxImagesToDisplay {
                NavigationLink(
                    destination: ImageGalleryView(updatePostedDate: galleryTitle, images: images, chosenIndex: 0)) {
                        ZStack {
                            KFImage(images[maxImagesToDisplay])
                                .placeholder {
                                    Rectangle()
                                        .modifier(Shimmering(configuration: .default))
                                }
                                .centerWidthCrop(width: 100, height: 100)
                                .cornerRadius(10)
                            
                            if images.count > maxImagesToDisplay {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Colors.Black)
                                        .opacity(0.7)
                                    
                                    Text("+\(images.count - maxImagesToDisplay) more")
                                        .font(Fonts.poppinsSubheadline())
                                        .foregroundColor(.white)
                                }
                            }
                        }
                        .frame(width: 100, height: 100)
                    }
            }
            
            if alignment == .left {
                Spacer()
            }
        }
        .frame(maxWidth: .infinity)
    }
}

struct FinewasteImageGallery_Previews: PreviewProvider {
    static var previews: some View {
        FinewasteImageGallery(images: [], maxImagesToDisplay: 3, galleryTitle: "", alignment: .left)
    }
}
