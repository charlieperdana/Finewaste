//
//  ProductInfoProfileView.swift
//  Finewaste
//
//  Created by charlie siagian on 23/11/21.
//

import SwiftUI

struct ProductInfoProfileView: View {
    @ObservedObject var model: ProfileViewModel
    var body: some View {
        VStack(alignment:.leading, spacing: 8) {
            VStack(alignment:.leading) {
                Text("Product Services")
                    .font(Fonts.poppinsCallout())
                
                Text(model.user.productServices?.joined(separator: ",") ?? "")
                    .font(Fonts.poppinsSubheadline())
            }
            
            VStack(alignment:.leading) {
                Text("Works")
                    .font(Fonts.poppinsCallout())
                
                ProductImagesProfileView(model: model)
                
            }
            

           
            
            HStack{
                Spacer()
            }
            

            
        }
    }
}

struct ProductInfoProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProductInfoProfileView(model: ProfileViewModel(userId: "8xayV4ivOsOSqUrNiD0kOHM7jih1"))
    }
}
