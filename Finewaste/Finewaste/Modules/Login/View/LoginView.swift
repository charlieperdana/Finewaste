//
//  LoginView.swift
//  Finewaste
//
//  Created by charlie siagian on 01/11/21.
//

import SwiftUI
import AuthenticationServices

enum LoginTrigger: String {
    case addContribution = "Sign in to add or contribute to project"
    case chat = "Sign in to start conversation with others"
    case addProject = "Sign in to create your own project"
}

struct LoginView: View {
    @EnvironmentObject var userInfo: UserInfo
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var loginData = LoginViewModel()
    @State private var email = ""
    @State private var fullname = ""
    var loginTrigger: LoginTrigger
    
    @State private var showLoginOnboarding = false
    
    private var loginImage: String {
        loginTrigger == .chat ? "ChatIllustration" : "ProjectIllustration"
    }
    
    var body: some View {
        VStack(spacing:20) {
            Image(loginImage)
            Text("Create a Profile")
                .font(Fonts.poppinsTitle())
                .foregroundColor(Colors.Turqoise)
            Text(loginTrigger.rawValue)
                .font(Fonts.poppinsBody())
                .foregroundColor(Colors.DarkGray)
            
            SignInWithAppleButton { (request) in
                
                //                requesting parameters from apple login
                loginData.nonce = EncryptionHelper.randomNonceString()
                request.requestedScopes = [.email, .fullName]
                request.nonce = EncryptionHelper.sha256(loginData.nonce)
                
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
                    
            
                    print("uuidModel : \(loginData.uuidUser)")
                    
                    
                    loginData.checkIfUuidExists(uuid: loginData.uuidUser) { result in
                        if result {
                            self.presentationMode.wrappedValue.dismiss()
                        } else {
                            self.showLoginOnboarding = true
                        }
                    }
                    
//                    self.showLoginOnboarding = true
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            .signInWithAppleButtonStyle(colorScheme == .dark ? .white : .black)
            .frame(height: 54)
            .cornerRadius(10)
            .padding(.horizontal)
            
            NavigationLink(destination: OnboardingView(), isActive: $showLoginOnboarding) {
                EmptyView()
            }
            .sheet(isPresented: $showLoginOnboarding, onDismiss: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.presentationMode.wrappedValue.dismiss()
                }
            }) {
                OnboardingView()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(loginTrigger: .chat)
    }
}
