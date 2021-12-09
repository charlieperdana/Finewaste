//
//  LoginViewModel.swift
//  Finewaste
//
//  Created by charlie siagian on 01/11/21.
//

import SwiftUI
import AuthenticationServices
import Firebase

class LoginViewModel: ObservableObject {
    
    @Published var nonce = ""
    @AppStorage("log_status") var logStatus = false
    @AppStorage("uuid_user") var uuidUser = ""
    
    let auth = Auth.auth()
    
    let db = Firestore.firestore()
    
    var isSignedIn : Bool{
        return auth.currentUser != nil
    }
    
    
    func authenticate(credential: ASAuthorizationAppleIDCredential) {
        
//        ambil token
        guard let token = credential.identityToken else {
            print("error with firebase")
            
            return
        }
        
//        Token string
        guard let tokenString = String(data: token, encoding: .utf8) else {
            print("error with token")
            
            return
        }
        
        let firebaseCredential = OAuthProvider.credential(withProviderID: "apple.com", idToken: tokenString, rawNonce: nonce)
        
        auth.signIn(with: firebaseCredential) { (result, err) in
            
            if let error = err {
                print("FinewasteError: \(error)")
//                print(error)
                return
            }
            
//            sukses
            print("FinewasteSuccess: ")
            print("Logged In Success")

            self.uuidUser = result?.user.uid ?? ""
            print(self.uuidUser)
            withAnimation(.easeInOut) {
                self.logStatus = true
            }
        }
    }
    
    func checkIfUuidExists(completion: @escaping (Bool) -> Void ) {
        
        let collectionUser = db.collection("users")
        
        collectionUser.document(Auth.auth().currentUser?.uid ?? "").getDocument { (snapshot, error ) in
            if  (snapshot?.exists)! {
                 print("User Document exist")
                completion(true)
            } else {
                 print("User Document does not exist")
                completion(false)
            }
        }
    }
}
