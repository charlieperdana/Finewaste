//
//  UpcyclerActiveView.swift
//  Finewaste
//
//  Created by charlie siagian on 15/11/21.
//

import SwiftUI

struct UpcyclerActiveView: View {
    @State private var productService = ""
    @State private var selectedImages = [UIImage]()
    
    var body: some View {
        
            VStack(spacing:16) {
                VStack(alignment:.leading, spacing:3) {
                    Text("Product Service")
                        .font(Fonts.poppinsCallout())
                    FinewasteTextField(placeholder: "e.g. Jonathan", text: $productService)
                }
                
                VStack(alignment:.leading, spacing:3) {
                    Text("Product Pictures")
                        .font(Fonts.poppinsCallout())
                    FinewasteImagePicker(selectedImages: $selectedImages)
                }
            }
        
    }
}

struct UpcyclerActiveView_Previews: PreviewProvider {
    static var previews: some View {
        UpcyclerActiveView()
    }
}
