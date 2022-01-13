//
//  GuestProfileView.swift
//  Finewaste
//
//  Created by charlie siagian on 23/11/21.
//

import SwiftUI

struct GuestProfileView: View {
    @StateObject var model = ProfileViewModel(userId: "")
    @State var isGuest = true
    
    @State var showLoginPage = false
    @State var showSettingPage = false
    
    @StateObject var loginData = LoginViewModel()
    
    var body: some View {
        VStack(alignment:.leading, spacing:16) {
            HeaderProfileView(model: model, isGuest: $isGuest)
            
            Text("Guest")
                .font(Fonts.poppinsCallout())
                .frame(alignment:.leading)
            
            AppleButtonView(model: loginData)
            
            Spacer()
            
            NavigationLink(destination: SettingView(), isActive: $showSettingPage) {}
            
        }
        .padding()
        .navigationTitle(Text("").font(Fonts.poppinsTitle()))
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(leading:
                                HStack {
            Text("Guest").font(Fonts.poppinsTitle())
        }
        )
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    self.showSettingPage = true
                } label: {
                    Image(systemName: "gearshape")
                        .font(.system(size: 17, weight: .bold, design: .default))
                        .foregroundColor(Colors.Turqoise)
                }


            }
        }
    }
}

struct GuestProfileView_Previews: PreviewProvider {
    static var previews: some View {
        GuestProfileView()
    }
}
