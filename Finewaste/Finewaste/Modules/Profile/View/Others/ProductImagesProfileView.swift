//
//  ProductImagesProfileView.swift
//  Finewaste
//
//  Created by charlie siagian on 23/11/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProductImagesProfileView: View {
    @ObservedObject var model: ProfileViewModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing:8) {
                
                ForEach(Array(model.user.productImagesUrl.enumerated()), id: \.offset){ index, image in
                    

                    
                    NavigationLink(destination: ImageGalleryView(updatePostedDate: "Product Images", images: model.user.productImagesUrl, chosenIndex: index)) {
                        WebImage(url: image)
                            .centerWidthCrop()
                            .frame(width: 100, height: 100)
                            .scaledToFill()
                            .clipped()
                        .cornerRadius(10)
                    }

                    
                }
            }
        }
    }
    
    private func getScale(proxy:GeometryProxy) -> CGFloat {
        var scale: CGFloat = 1.1
        return scale
    }
}

struct ProductImagesProfileView_Previews: PreviewProvider {
    static var previews: some View {
        //        ProductImagesProfileView()
        ProductImagesProfileView(model: ProfileViewModel(userId: "8xayV4ivOsOSqUrNiD0kOHM7jih1"))
    }
}
