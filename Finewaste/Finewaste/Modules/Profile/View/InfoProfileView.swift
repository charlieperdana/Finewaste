//
//  InfoProfileView.swift
//  Finewaste
//
//  Created by charlie siagian on 13/11/21.
//

import SwiftUI

struct InfoProfileView: View {
    @ObservedObject var model: ProfileViewModel
    
    var body: some View {
        VStack(alignment:.leading) {
            Text(model.user.name ?? "---")
                .font(Fonts.poppinsCallout())
            

            Text(model.user.name ?? "---")
                .font(Fonts.poppinsSubheadline())
            
            HStack{
                Spacer()
            }

            
        }
        
    }
}

struct InfoProfileView_Previews: PreviewProvider {
    static var previews: some View {
        InfoProfileView(model: ProfileViewModel(userId: "8xayV4ivOsOSqUrNiD0kOHM7jih1"))
    }
}
