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
    
    @StateObject var loginData = LoginViewModel()
    @State private var email = ""
    @State private var fullname = ""
    var loginTrigger: LoginTrigger
    
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

            AppleButtonView(model: loginData)
                .padding(.horizontal, 40)
            

        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(loginTrigger: .chat)
    }
}
