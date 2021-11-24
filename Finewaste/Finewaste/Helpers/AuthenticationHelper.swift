//
//  AuthenticationHelper.swift
//  Finewaste
//
//  Created by Andrean Lay on 12/11/21.
//

import FirebaseAuth

final class AuthenticationHelper {
    static let shared = AuthenticationHelper()
    
    private let usernameKey = "CURRENT_USERNAME"
    private let displayNameKey = "CURRENT_DISPLAY_NAME"
    private let profilePhotoKey = "CURRENT_PROFILE_PHOTO_URL"
    
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
        if let user = Auth.auth().currentUser {
            return user.uid
        } else {
            return "---"
        }
    }
    
    var username: String {
        get {
            UserDefaults.standard.string(forKey: usernameKey) ?? "---"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: usernameKey)
        }
    }
    
    var displayName: String {
        get {
            UserDefaults.standard.string(forKey: displayNameKey) ?? "---"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: displayNameKey)
        }
    }
    
    var profilePhotoUrl: String {
        get {
            UserDefaults.standard.string(forKey: profilePhotoKey) ?? "---"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: profilePhotoKey)
        }
    }
}
