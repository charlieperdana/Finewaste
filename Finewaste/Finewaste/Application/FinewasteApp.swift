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

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
