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
                
                ForEach(model.user.productImages ?? [] as [String], id: \.self){ image in
                    GeometryReader { proxy in
                        
                        let scale  = getScale(proxy: proxy)
                        
                        WebImage(url: URL(string: image))
                            .centerWidthCrop()
                            .frame(width: 100, height: 100)
                            .scaledToFill()
                            .clipped()
                            .cornerRadius(10)
                    }
                    
                    .frame(width: 100, height: 150)
                    
                    
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
