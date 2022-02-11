//
//  TabBarItemView.swift
//  Finewaste
//
//  Created by Andrean Lay on 06/12/21.
//

import SwiftUI

struct TabBarItemView: View {
    var tabBarView: AnyView
    var navBarStyle: NavigationBarItem.TitleDisplayMode
    @Binding var selectedTab: SelectedTab
    
    var body: some View {
        NavigationView {
            ZStack {
                tabBarView
                
                VStack {
                    Spacer()
                    FinewasteTabBar(currentSelectedTab: $selectedTab)
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarTitleDisplayMode(navBarStyle)
        }
    }
}

struct TabBarItemView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarItemView(tabBarView: AnyView(EmptyView()), navBarStyle: .large, selectedTab: .constant(.profile))
    }
}
