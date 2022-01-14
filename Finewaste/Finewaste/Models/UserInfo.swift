//
//  UserInfo.swift
//  Finewaste
//
//  Created by charlie siagian on 01/11/21.
//

import Foundation

class UserInfo: ObservableObject {
    enum FBAuthState {
        case undefined, signedOut, signedIn
    }
    
    @Published var isUserAuthenticated : FBAuthState = .undefined
    
    func configureFirebaseStateDidChange() {
        self.isUserAuthenticated = .signedOut
//        self.isUserAuthenticated = .signedIn
    }
}
