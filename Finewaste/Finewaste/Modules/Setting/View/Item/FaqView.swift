//
//  FaqView.swift
//  Finewaste
//
//  Created by charlie siagian on 17/11/21.
//

import SwiftUI

struct FaqView: View {
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
        .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Frequently Asked Questions").font(Fonts.poppinsHeadline())
                            .frame(width: 100)
                    }
                }
            }
    }
}

struct FaqView_Previews: PreviewProvider {
    static var previews: some View {
        FaqView()
    }
}
