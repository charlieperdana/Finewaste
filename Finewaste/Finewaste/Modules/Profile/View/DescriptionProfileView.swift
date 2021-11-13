//
//  DescriptionProfileView.swift
//  Finewaste
//
//  Created by charlie siagian on 13/11/21.
//

import SwiftUI

struct DescriptionProfileView: View {
    var body: some View {
        VStack(alignment:.leading, spacing: 8) {
            Text("Description")
                .font(Fonts.poppinsCallout())
            

            Text("Love upcycling you!")
                .font(Fonts.poppinsSubheadline())
            
            HStack{
                Spacer()
            }

            
        }
        
    }
}

struct DescriptionProfileView_Previews: PreviewProvider {
    static var previews: some View {
        DescriptionProfileView()
    }
}
