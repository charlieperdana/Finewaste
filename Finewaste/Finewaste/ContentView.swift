//
//  ContentView.swift
//  Finewaste
//
//  Created by charlie siagian on 26/10/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @AppStorage("log_status") var logStatus = false
    var body: some View {
        
        ZStack {
            if logStatus {
//                HomeView()
                OnboardingView()
            }
            else {
                LoginView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
