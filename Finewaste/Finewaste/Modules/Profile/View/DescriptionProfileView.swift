//
//  DescriptionProfileView.swift
//  Finewaste
//
//  Created by charlie siagian on 13/11/21.
//

import SwiftUI

struct DescriptionProfileView: View {
    
    @ObservedObject var model: ProfileViewModel
    
    var body: some View {
        VStack(alignment:.leading) {
            Text("Description")
                .font(Fonts.poppinsCallout())

            Text(model.user.description ?? "--")
                .font(Fonts.poppinsSubheadline())
            
            HStack{
                Spacer()
            }

            
        }
        
    }
}

struct DescriptionProfileView_Previews: PreviewProvider {
    static var previews: some View {
        DescriptionProfileView(model: ProfileViewModel(userId: "8xayV4ivOsOSqUrNiD0kOHM7jih1"))
    }
}
