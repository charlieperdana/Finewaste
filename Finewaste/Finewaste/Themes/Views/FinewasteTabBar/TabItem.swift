//
//  TabItem.swift
//  Finewaste
//
//  Created by Andrean Lay on 05/02/22.
//

import SwiftUI

struct TabItem: View {
    var iconName: String
    var representedTab: SelectedTab
    @Binding var currentSelectedTab: SelectedTab
    
    private var tabColor: Color {
        return self.currentSelectedTab == self.representedTab ? Colors.Turqoise : Colors.DarkGray
    }
    
    var body: some View {
        VStack (spacing: 5){
            Button(action: {
                self.currentSelectedTab = representedTab
            }){
                Image(systemName: iconName)
                    .font(.title3)
                    .foregroundColor(tabColor)
                    .padding(.horizontal)
            }
            Text(representedTab.rawValue)
                .font(Fonts.poppinsCaption2())
                .foregroundColor(tabColor)
            
        }
    }
}

struct TabItem_Previews: PreviewProvider {
    static var previews: some View {
        TabItem(iconName: "scissors", representedTab: .profile, currentSelectedTab: .constant(.projects))
    }
}
