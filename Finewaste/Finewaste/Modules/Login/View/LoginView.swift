//
//  LoginView.swift
//  Finewaste
//
//  Created by charlie siagian on 01/11/21.
//

import SwiftUI
import AuthenticationServices

struct LoginView: View {
    @EnvironmentObject var userInfo: UserInfo
    
    @StateObject var loginData = LoginViewModel()
    @State private var email = ""
    @State private var fullname = ""
    
    var body: some View {
        VStack(spacing:20) {
            Image("loginImage")
            Text("Create a Profile")
                .font(Fonts.poppinsTitle())
                .foregroundColor(Colors.Turqoise)
            Text("Sign in to add or contribute to project")
                .font(Fonts.poppinsBody())
                .foregroundColor(Colors.DarkGray)

            SignInWithAppleButton { (request) in
                
//                requesting parameters from apple login
                loginData.nonce = LoginHelper.randomNonceString()
                request.requestedScopes = [.email, .fullName]
                request.nonce = LoginHelper.sha256(loginData.nonce)
                
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
                    loginData.authenticate(credential: credential)
                    
                
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            .signInWithAppleButtonStyle(.black)
            .frame(height: 55)
            .padding(.horizontal, 40)
            

        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
