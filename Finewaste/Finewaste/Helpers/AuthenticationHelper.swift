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
//        return true 
        
        if Auth.auth().currentUser != nil {
            return true
        } else {
            return false
        }
    }
    
    var userId: String {
//        return "VmdNLUC3ZDNtOCVO2h1jSyPP86E2"
        
        if let user = Auth.auth().currentUser {
            return user.uid
        } else {
            return "---"
        }
    }
    
    var username: String {
        get {
//            return "simulatorOwner"
            UserDefaults.standard.string(forKey: usernameKey) ?? "---"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: usernameKey)
        }
    }
    
    var displayName: String {
        get {
//            return "I am simulator"
            UserDefaults.standard.string(forKey: displayNameKey) ?? "---"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: displayNameKey)
        }
    }
    
    var profilePhotoUrl: String {
        get {
//            return "https://ggsc.s3.amazonaws.com/images/uploads/The_Science-Backed_Benefits_of_Being_a_Dog_Owner.jpg"
            UserDefaults.standard.string(forKey: profilePhotoKey) ?? "---"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: profilePhotoKey)
        }
    }
}
