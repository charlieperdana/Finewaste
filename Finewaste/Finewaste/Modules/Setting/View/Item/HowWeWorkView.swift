//
//  HowWeWorkView.swift
//  Finewaste
//
//  Created by charlie siagian on 17/11/21.
//

import SwiftUI

struct HowWeWorkView: View {
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
        .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("How We Work").font(Fonts.poppinsHeadline())
                    }
                }
            }
    }
}

struct HowWeWorkView_Previews: PreviewProvider {
    static var previews: some View {
        HowWeWorkView()
    }
}
