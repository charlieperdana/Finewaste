//
//  FinewasteApp.swift
//  Finewaste
//
//  Created by charlie siagian on 26/10/21.
//

import SwiftUI
import Firebase
import CoreLocation

@main
struct FinewasteApp: App {
    let persistenceController = PersistenceController.shared
    @State private var test = 0

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ProjectDetailView(projectId: "dummyData")
                .foregroundColor(Colors.DarkGray)
        }
    }
}
