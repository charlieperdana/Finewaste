//
//  ImageCompressor.swift
//  Finewaste
//
//  Created by Andrean Lay on 11/11/21.
//

import UIKit

final class ImageCompressor {
    static let shared = ImageCompressor()
    
    private init() {}
    
    func compressImages(images: [UIImage]) -> [Data] {
        var imagesData = [Data]()
        images.forEach { image in
            if let compressedImageData = image.jpegData(compressionQuality: 0.8) {
                imagesData.append(compressedImageData)
            }
        }
        
        return imagesData
    }
}
