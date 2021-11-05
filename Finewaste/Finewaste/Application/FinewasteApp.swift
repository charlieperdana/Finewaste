//
//  FinewasteApp.swift
//  Finewaste
//
//  Created by charlie siagian on 26/10/21.
//

import SwiftUI
import Firebase

@main
struct FinewasteApp: App {
    let persistenceController = PersistenceController.shared
    @State private var test = 0

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
//            ProjectDetailView()
//                .foregroundColor(Colors.DarkGray)
            ContentView()
        }
    }
}
