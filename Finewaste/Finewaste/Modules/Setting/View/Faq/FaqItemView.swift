//
//  FaqItemView.swift
//  Finewaste
//
//  Created by charlie siagian on 25/11/21.
//

import SwiftUI

struct FaqItemView: View {
    let item : String
    var body: some View {
        VStack {
            Text("Hello, World!")
        }
        .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text(item).font(Fonts.poppinsHeadline())
                    }
                }
            }

    }
}

struct FaqItemView_Previews: PreviewProvider {
    static var previews: some View {
        FaqItemView(item: "Item")
    }
}
