//
//  ProjectUpdateCard.swift
//  Finewaste
//
//  Created by Andrean Lay on 03/11/21.
//

import SwiftUI

struct ProjectUpdateCard: View {
    private var updateDate = "---"
    private var updateDescription = "---"
    private var updateImages = [URL]()
    
    init(update: ProjectUpdate) {
        if let date = update.createdDate {
            updateDate = TimestampHelper.shared.timestampToStringDate(timestamp: date, format: .simple)
        }
        if let description = update.description {
            updateDescription = description
        }
        if let images = update.images {
            updateImages = images.compactMap {
                URL(string: $0)
            }
        }
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Colors.White)
                .modifier(CardShadow())
            
            VStack(alignment: .leading, spacing: 16) {
                Text(updateDate)
                    .font(Fonts.poppinsCallout())
                Text(updateDescription)
                    .font(Fonts.poppinsSubheadline())
                
                FinewasteImageGallery(images: updateImages, maxImagesToDisplay: min(2, updateImages.count), galleryTitle: updateDate, alignment: .left)
            }
            .offset(x: 8)
            .padding([.top, .bottom])
        }
    }
}
