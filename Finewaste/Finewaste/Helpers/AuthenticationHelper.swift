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
    
    var userId: String {
        return "VmdNLUC3ZDNtOCVO2h1jSyPP86E2"
        if let user = Auth.auth().currentUser {
            return user.uid
        } else {
            return "---"
        }
    }
}
