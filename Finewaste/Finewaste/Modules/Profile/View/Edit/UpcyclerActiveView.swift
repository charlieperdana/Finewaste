//
//  UpcyclerActiveView.swift
//  Finewaste
//
//  Created by charlie siagian on 15/11/21.
//

import SwiftUI

struct UpcyclerActiveView: View {
    @Binding var productService : String
    @Binding var selectedImages : [UIImage]
    @ObservedObject var model: ProfileViewModel
    
    var body: some View {
        
            VStack(spacing:16) {
                VStack(alignment:.leading, spacing:3) {
                    Text("Product Service")
                        .font(Fonts.poppinsCallout())
                    FinewasteTextField(placeholder: "e.g. totebag, jacket, etc", text: $productService)
                }
                
                VStack(alignment:.leading, spacing:3) {
                    Text("Product Pictures")
                        .font(Fonts.poppinsCallout())
                    FinewasteImagePicker(selectedImages: $selectedImages)
                }
            }
            .onReceive(self.model.$user) { user in
                print("isi service \(user.productImages)")
                self.productService = user.productImages?.joined(separator: ", ") ?? "cinta"
            }
            
        
    }
}

struct UpcyclerActiveView_Previews: PreviewProvider {
    @State static var service = ""
    @State static var images = [UIImage]()
    @State static var model = ProfileViewModel(userId: "8xayV4ivOsOSqUrNiD0kOHM7jih1")
    static var previews: some View {
        UpcyclerActiveView(productService: $service, selectedImages:$images, model: ProfileViewModel(userId: "8xayV4ivOsOSqUrNiD0kOHM7jih1"))
    }
}
