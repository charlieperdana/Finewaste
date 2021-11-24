//
//  ImageGalleryView.swift
//  Finewaste
//
//  Created by Andrean Lay on 04/11/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct ImageGalleryView: View {
    var updatePostedDate: String
    var images: [URL]
    
    @State private var currentImage = URL(string: "")
    
    init(updatePostedDate: String, images: [URL], chosenIndex: Int) {
        self.updatePostedDate = updatePostedDate
        self.images = images
    
        self._currentImage = State(wrappedValue: images[chosenIndex])
    }
    
    var body: some View {
        NavigationView {
            VStack {
                WebImage(url: self.currentImage)
                    .resizable()
                    .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fit)
                Spacer()
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 4) {
                        ForEach(images, id: \.self) { imageUrl in
                            WebImage(url: imageUrl)
                                .resizable()
                                .frame(width: 67, height: 67)
                                .onTapGesture {
                                    self.currentImage = imageUrl
                                }
                        }
                        Spacer()
                    }
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
        ImageGalleryView(updatePostedDate: "", images: [], chosenIndex: 0)
    }
}
