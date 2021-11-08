//
//  ProjectUpdateCard.swift
//  Finewaste
//
//  Created by Andrean Lay on 03/11/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProjectUpdateCard: View {
    private var updateDate = "---"
    private var updateDescription = "---"
    private var updateImages = [URL]()
    
    init(update: ProjectUpdate) {
        if let date = update.createdDate {
            updateDate = TimestampHelper.shared.timestampToStringDate(timestamp: date)
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
                .shadow(color: Colors.Gray.opacity(0.4), radius: 1, x: 2, y: 2)
                .shadow(color: Colors.Gray.opacity(0.4), radius: 1, x: -2, y: -2)
            
            VStack(alignment: .leading, spacing: 16) {
                Text(updateDate)
                    .font(Fonts.poppinsCallout())
                Text(updateDescription)
                    .font(Fonts.poppinsSubheadline())
                
                HStack(spacing: 16) {
                    ForEach(0..<min(2, updateImages.count)) { index in
                        NavigationLink(
                            destination: ImageGalleryView(updatePostedDate: updateDate, images: updateImages, chosenIndex: index)) {
                            WebImage(url: updateImages[index])
                                .resizable()
                                .frame(width: 100, height: 100)
                                .cornerRadius(10)
                        }
                    }
                    if updateImages.count > 2 {
                        NavigationLink(
                            destination: ImageGalleryView(updatePostedDate: updateDate, images: updateImages, chosenIndex: 0)) {
                            ZStack {
                                WebImage(url: updateImages[2])
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(10)
                                
                                if updateImages.count > 3 {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Colors.Black)
                                            .opacity(0.7)
                                        
                                        Text("See all")
                                            .font(Fonts.poppinsSubheadline())
                                            .foregroundColor(Colors.White)
                                    }
                                }
                            }
                        }
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity)
            }
            .offset(x: 8)
            .padding([.top, .bottom])
        }
    }
}
