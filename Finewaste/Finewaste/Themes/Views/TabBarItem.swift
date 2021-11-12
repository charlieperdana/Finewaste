//
//  TabBarItem.swift
//  Finewaste
//
//  Created by Andrean Lay on 12/11/21.
//

import SwiftUI

struct TabBarItem: View {
    var iconName: String
    var title: String
    
    var body: some View {
        VStack(spacing: 5) {
            Image(systemName: iconName)
                .renderingMode(.original)
            Text(title)
                .font(Fonts.poppinsCaption2())
        }
    }
}

struct TabBarItem_Previews: PreviewProvider {
    static var previews: some View {
        TabBarItem(iconName: "scissors", title: "Projects")
    }
}
