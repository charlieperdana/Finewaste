//
//  ContributionMaterial.swift
//  Finewaste
//
//  Created by Andrean Lay on 15/11/21.
//

import SwiftUI

struct ContributionMaterialItem: View {
    private var materialName = "---"
    private var materialQuantity = 0
    private var materialImages = [URL]()
    
    init(material: ContributionMaterial) {
        if let materialName = material.name {
            self.materialName = materialName
        }
        if let materialQuantity = material.quantity {
            self.materialQuantity = materialQuantity
        }
        if let images = material.images {
            self.materialImages = images.compactMap { URL(string: $0) }
        }
    }
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 8) {
                Text("\(materialQuantity) pcs")
                Text(materialName)
            }
            .font(Fonts.poppinsSubheadline())
            
            Spacer()
            
            FinewasteImageGallery(images: materialImages,
                                  maxImagesToDisplay: 1,
                                  galleryTitle: materialName,
                                  alignment: .right)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct ContributionMaterialItem_Previews: PreviewProvider {
    static var previews: some View {
        ContributionMaterialItem(material: ContributionMaterial())
    }
}
