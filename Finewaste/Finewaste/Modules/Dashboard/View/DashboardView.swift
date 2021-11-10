//
//  DashboardView.swift
//  Finewaste
//
//  Created by charlie siagian on 08/11/21.
//

import SwiftUI

struct DashboardView: View {
    @State var selected = 0
    var body: some View {
//        ZStack(alignment: .bottom) {
        VStack{
            VStack{
                if self.selected == 0 {
                    MainProjectView()
                } else if self.selected == 1 {
                    HomeView()
                    
                }
                else if self.selected == 2 {
                    NavigationView {
                        VStack(spacing: 20) {
                            Text("Your Status")
                                .navigationBarTitle("Status")
                            
                        }
                    }
                    .navigationBarHidden(true)
                }
                else if self.selected == 3 {
                    NavigationView {
                        VStack(spacing: 20) {
                            Text("Your Profile")
                                .navigationBarTitle("Profile")
                            
                        }
                    }
                    .navigationBarHidden(true)
                }
            }
            
            Divider()
            FloatingTabBarView(selected: $selected)
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
