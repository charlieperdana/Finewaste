//
//  RootView.swift
//  Finewaste
//
//  Created by Andrean Lay on 12/11/21.
//

import SwiftUI

enum SelectedTab: Int {
    case projects = 0
    case chat = 1
    case status = 2
    case profile = 3
}

final class TabBarManager: ObservableObject {
    @Published var isTabBarHidden = false
}

struct RootView: View {
    //    @State private var selectedTab: SelectedTab = .projects
    @State private var selectedTab = 0
    
    var body: some View {
        Group {
            switch selectedTab {
            case 0:
                TabBarItemView(tabBarView: AnyView(MainProjectView()), navBarStyle: .large, selectedTab: $selectedTab)
            case 1:
                TabBarItemView(tabBarView: AnyView(ChatListView()), navBarStyle: .large, selectedTab: $selectedTab)
            case 2:
                TabBarItemView(tabBarView: AnyView(ContributionStatusView()), navBarStyle: .large, selectedTab: $selectedTab)
            case 3:
                TabBarItemView(tabBarView: AnyView(MyProfileView()), navBarStyle: .large, selectedTab: $selectedTab)
            default:
                TabBarItemView(tabBarView: AnyView(EmptyView()), navBarStyle: .inline, selectedTab: $selectedTab)
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
