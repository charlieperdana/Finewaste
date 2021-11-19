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
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContributionStatusView()
        }
    }
}
