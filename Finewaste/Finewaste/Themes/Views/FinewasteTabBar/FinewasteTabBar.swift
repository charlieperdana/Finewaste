//
//  FloatingTabBarView.swift
//  Finewaste
//
//  Created by charlie siagian on 07/11/21.
//

import SwiftUI

struct FinewasteTabBar: View {
    @Binding var currentSelectedTab : SelectedTab
    
    var body: some View {
        ZStack(alignment: .top) {
            HStack {
                TabItem(iconName: "scissors", representedTab: .projects, currentSelectedTab: $currentSelectedTab)
                
                Spacer(minLength: 15)
                
                TabItem(iconName: "bubble.left.and.bubble.right", representedTab: .chat, currentSelectedTab: $currentSelectedTab)
                
                Spacer(minLength: 15)
                
                TabItem(iconName: "clock.arrow.circlepath", representedTab: .contribution, currentSelectedTab: $currentSelectedTab)
                
                Spacer(minLength: 15)

                TabItem(iconName: "person.crop.circle", representedTab: .profile, currentSelectedTab: $currentSelectedTab)
            }
            .padding(.top, 10)
            .padding(.horizontal, 20)
            
            Rectangle()
                .fill(Colors.PlaceholderGray)
                .frame(height: 1)
        }
        .padding(.bottom, 35)
        .background(Colors.White)
    }
}

struct FinewasteTabBar_Previews: PreviewProvider {
    @State static var selected: SelectedTab = .projects
    
    static var previews: some View {
        FinewasteTabBar(currentSelectedTab: $selected)
    }
}
