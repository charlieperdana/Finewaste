//
//  RootView.swift
//  Finewaste
//
//  Created by Andrean Lay on 12/11/21.
//

import SwiftUI

enum SelectedTab: String {
    case projects = "Projects"
    case chat = "Chat"
    case contribution = "Status"
    case profile = "Profile"
}

struct RootView: View {
    @State private var selectedTab: SelectedTab = .projects
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "Poppins-SemiBold", size: 28)!]
        
        UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: "Poppins-SemiBold", size: 17)!]
    }
    
    var body: some View {
        Group {
            switch selectedTab {
            case .projects:
                TabBarItemView(tabBarView: AnyView(MainProjectView()), navBarStyle: .large, selectedTab: $selectedTab)
            case .chat:
                TabBarItemView(tabBarView: AnyView(ChatListView()), navBarStyle: .large, selectedTab: $selectedTab)
            case .contribution:
                TabBarItemView(tabBarView: AnyView(ContributionStatusView()), navBarStyle: .large, selectedTab: $selectedTab)
            case .profile:
                if !AuthenticationHelper.shared.isLoggedIn {
                    TabBarItemView(tabBarView: AnyView(GuestProfileView()), navBarStyle: .large, selectedTab: $selectedTab)
                } else {
                    TabBarItemView(tabBarView: AnyView(MyProfileView()), navBarStyle: .large, selectedTab: $selectedTab)
                }
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
