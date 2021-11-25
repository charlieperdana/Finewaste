//
//  ContactUsView.swift
//  Finewaste
//
//  Created by charlie siagian on 17/11/21.
//

import SwiftUI

struct ContactUsView: View {
    var body: some View {
        VStack {
            Text("Hello, World!")
        }
        .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Contact Us").font(Fonts.poppinsHeadline())
                            .frame(width: 100)
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
