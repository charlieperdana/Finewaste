//
//  AppleButtonView.swift
//  Finewaste
//
//  Created by charlie siagian on 23/11/21.
//

import SwiftUI
import AuthenticationServices

struct AppleButtonView: View {
    @ObservedObject var model: LoginViewModel
    
    var body: some View {
        SignInWithAppleButton { (request) in
            
//                requesting parameters from apple login
            model.nonce = EncryptionHelper.randomNonceString()
            request.requestedScopes = [.email, .fullName]
            request.nonce = EncryptionHelper.sha256(model.nonce)
            
        } onCompletion: { (result) in
            
//                getting error or success
            switch result {
            case .success(let user):
                print("success")
//                    do login with firebase
                guard let credential = user.credential as? ASAuthorizationAppleIDCredential else {
                    print("error with firebase")
                    return
                }
                model.authenticate(credential: credential)
                
            
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        .signInWithAppleButtonStyle(.black)
        .frame(height: 55)
//        .padding(.horizontal, 40)
    }
}

struct AppleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AppleButtonView(model: LoginViewModel())
    }
}
