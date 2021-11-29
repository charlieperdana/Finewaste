//
//  FaqItemView.swift
//  Finewaste
//
//  Created by charlie siagian on 25/11/21.
//

import SwiftUI

struct FaqItemView: View {
    let title : String
    var body: some View {
        VStack {
            Text("Hello, World!")
        }
        .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text(title).font(Fonts.poppinsHeadline())
                            .frame(width:200)
                    }
                }
            }

    }
}

struct FaqItemView_Previews: PreviewProvider {
    static var previews: some View {
        FaqItemView(title: "Item")
    }
}
