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
        NavigationView {
            ZStack {
                VStack {
                    switch selectedTab {
                    case 0:
                        MainProjectView()
                    case 1:
                        ChatListView()
                    case 2:
                        ContributionStatusView()
                    case 3:
                        if !AuthenticationHelper.shared.isLoggedIn {
                            GuestProfileView()
                        } else {
                            MyProfileView()
                        }
                        
                    default:
                        EmptyView()
                    }
                    Spacer()
                }
                .onChange(of: selectedTab) { [selectedTab] _ in
                    if modalDismissed {
                        self.modalDismissed = false
                        return
                    }
                    
                    self.oldSelectedTab = selectedTab
//                    if !AuthenticationHelper.shared.isLoggedIn {
//                        self.isPresentingLoginSheet.toggle()
//
//
//                    }
                }
                
                VStack {
                    Spacer()
                    FloatingTabBarView(selected: $selectedTab)
                }
            }
            .navigationViewStyle(.stack)
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
