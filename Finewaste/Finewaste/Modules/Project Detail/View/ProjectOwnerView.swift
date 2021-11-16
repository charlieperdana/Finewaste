//
//  ProjectOwnerView.swift
//  Finewaste
//
//  Created by Andrean Lay on 03/11/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProjectOwnerView: View {
    @State private var isShowingLoginModal = false
    
    var body: some View {
        HStack {
            WebImage(url: URL(string: "https://s3.amazonaws.com/www-inside-design/uploads/2020/10/aspect-ratios-blogpost-1x1-1.png"))
                .resizable()
                .frame(width: 44, height: 44)
                .clipShape(Circle())
            Text("DonateforCycle.id")
                .font(Fonts.poppinsCallout())
            Spacer()
            FinewasteButtonFill(text: "Chat", size: .small, isEnabled: true) {
//                if !AuthenticationHelper.shared.isLoggedIn {
//                    isShowingLoginModal.toggle()
//                    return
//                }
            }
        }
        .padding(.all, 16)
        .sheet(isPresented: $isShowingLoginModal) {
            LoginView(loginTrigger: .chat)
        }
    }
}

struct ProjectOwnerView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectOwnerView()
    }
}
