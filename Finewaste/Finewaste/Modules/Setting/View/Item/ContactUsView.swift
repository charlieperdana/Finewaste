//
//  ContactUsView.swift
//  Finewaste
//
//  Created by charlie siagian on 17/11/21.
//

import SwiftUI

struct ContactUsView: View {
    var body: some View {
        VStack(alignment:.leading, spacing: 15) {
            Text("Address: BSD Green Office Park 9, BSD City, Sampora, Kec. Cisauk, Tangerang, Banten 15345, Indonesia")
            
            Text("Email: wethex.wtx@gmail.com ").fontWeight(.medium)
            
        }
        .padding()
        .font(Fonts.poppinsBody())
        .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Contact Us").font(Fonts.poppinsHeadline())
                            .frame(width: 200)
                    }
                }
            }
    }
}

struct ContactUsView_Previews: PreviewProvider {
    static var previews: some View {
        ContactUsView()
    }
}
