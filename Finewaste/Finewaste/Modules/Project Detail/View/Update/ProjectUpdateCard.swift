//
//  ProjectUpdateCard.swift
//  Finewaste
//
//  Created by Andrean Lay on 03/11/21.
//

import SwiftUI

struct ProjectUpdateCard: View {
    let dummyImages: [String] = Array(repeating: "exampleImage", count: 4)
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Colors.White)
                .shadow(color: Colors.Gray.opacity(0.4), radius: 1, x: 2, y: 2)
                .shadow(color: Colors.Gray.opacity(0.4), radius: 1, x: -2, y: -2)
            
            VStack(alignment: .leading, spacing: 16) {
                Text("13 October 2021")
                    .font(Fonts.poppinsCallout())
                Text("Mulai produksi pembuatan totebag")
                    .font(Fonts.poppinsSubheadline())
                
                HStack(spacing: 16) {
                    ForEach(0..<min(2, dummyImages.count)) { index in
                        Image(dummyImages[index])
                            .resizable()
                            .frame(width: 100, height: 100)
                            .cornerRadius(10)
                    }
                    if dummyImages.count > 2 {
                        ZStack {
                            Image(dummyImages[2])
                                .resizable()
                                .frame(width: 100, height: 100)
                                .cornerRadius(10)
                            
                            if dummyImages.count > 3 {
                                NavigationLink(
                                    destination: ImageGalleryView(updatePostedDate: "13 October 2021", images: dummyImages)) {
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
        }
    }
}

struct ProjectUpdateCard_Previews: PreviewProvider {
    static var previews: some View {
        ProjectUpdateCard()
    }
}
