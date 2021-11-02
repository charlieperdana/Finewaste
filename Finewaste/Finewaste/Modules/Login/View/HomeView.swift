//
//  HomeView.swift
//  Finewaste
//
//  Created by charlie siagian on 01/11/21.
//

import SwiftUI
import Firebase

struct HomeView: View {
    @EnvironmentObject var userInfo: UserInfo
    
    @AppStorage("log_status") var logStatus = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Login Success using Apple ID")
                    .navigationBarTitle("Firebase Login")
                    .navigationBarItems(trailing: Button("Log Out") {

                        DispatchQueue.global(qos: .background).async {
                            try? Auth.auth().signOut()
                        }
                        
                        withAnimation(.easeInOut) {
                            logStatus = false
                        }
                })
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
