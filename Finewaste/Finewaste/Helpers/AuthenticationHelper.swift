//
//  AuthenticationHelper.swift
//  Finewaste
//
//  Created by Andrean Lay on 12/11/21.
//

import FirebaseAuth

final class AuthenticationHelper {
    static let shared = AuthenticationHelper()
    
    private init() {
        
    }
    
    var isLoggedIn: Bool {
        if Auth.auth().currentUser != nil {
            return true
        } else {
            return false
        }
    }
}
