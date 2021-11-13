//
//  InfoProfileView.swift
//  Finewaste
//
//  Created by charlie siagian on 13/11/21.
//

import SwiftUI

struct InfoProfileView: View {
    var body: some View {
        VStack(alignment:.leading) {
            Text("Charlie")
                .font(Fonts.poppinsCallout())
            

            Text("Pematangsiantar, Sumut")
                .font(Fonts.poppinsSubheadline())
            
            HStack{
                Spacer()
            }

            
        }
        
    }
}

struct InfoProfileView_Previews: PreviewProvider {
    static var previews: some View {
        InfoProfileView()
    }
}
