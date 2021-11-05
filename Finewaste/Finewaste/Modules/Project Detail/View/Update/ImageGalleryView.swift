//
//  ImageGalleryView.swift
//  Finewaste
//
//  Created by Andrean Lay on 04/11/21.
//

import SwiftUI

struct ImageGalleryView: View {
    var updatePostedDate: String
    var images: [String]
    
    @State private var currentImage: String
    
    init(updatePostedDate: String, images: [String]) {
        self.updatePostedDate = updatePostedDate
        self.images = images
        
        self.currentImage = images[0]
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Image(self.currentImage)
                    .resizable()
                    .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fit)
                Spacer()
                
                HStack(spacing: 4) {
                    ForEach(images, id: \.self) { imageName in
                        Image(imageName)
                            .resizable()
                            .frame(width: 67, height: 67)
                            .onTapGesture {
                                self.currentImage = imageName
                            }
                    }
                    Spacer()
                }
            }
        }
        .navigationTitle(updatePostedDate)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                NavigationBackButton()
            }
        }
    }
    
    private func onBackButtonTapped() {
        
    }
}

struct ImageGalleryView_Previews: PreviewProvider {
    static var previews: some View {
        ImageGalleryView(updatePostedDate: "", images: [])
    }
}
