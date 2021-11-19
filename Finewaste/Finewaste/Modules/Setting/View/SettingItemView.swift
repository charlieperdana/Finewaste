//
//  SettingItemView.swift
//  Finewaste
//
//  Created by charlie siagian on 17/11/21.
//

import SwiftUI

struct SettingItemView: View {
    let item : String
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
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

struct SettingItemView_Previews: PreviewProvider {
    static var previews: some View {
        SettingItemView(item: "Item")
    }
}
