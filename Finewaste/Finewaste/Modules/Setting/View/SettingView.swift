//
//  SettingView.swift
//  Finewaste
//
//  Created by charlie siagian on 17/11/21.
//

import SwiftUI
import Firebase

struct SettingView: View {
    
    let settingItem = [
        "How We Work",
        "Frequently Asked Questions",
        "Terms of Use",
        "Privacy Policy",
        "Contact Us",
        "Sign Out",
    ]
    
    init() {
        UITableView.appearance().sectionFooterHeight = 0
    }
    
    var body: some View {
        
        VStack {
            //                List(settingItem, id: \.self){ item in
            //                    NavigationLink(destination: SettingItemView(item: item)) {
            //                        Text(item)
            //                    }
            //
            //                }
            
            List {
                Section(header: Text("")) {
                    NavigationLink(destination: HowWeWorkView()) {
                        Text("How We Work").font(Fonts.poppinsBody())
                    }
                    NavigationLink(destination: FaqView()) {
                        Text("Frequently Asked Questions").font(Fonts.poppinsBody())
                    }
                    
                }
                
                Section(header: Text("")) {
                    NavigationLink(destination: TermOfUseView()) {
                        Text("Terms of Use").font(Fonts.poppinsBody())
                    }
                    NavigationLink(destination: PrivacyPolicyView()) {
                        Text("Privacy Policy").font(Fonts.poppinsBody())
                    }
                    NavigationLink(destination: ContactUsView()) {
                        Text("Contact Us").font(Fonts.poppinsBody())
                    }
                    
                }
                
                Section(header: Text("")) {
//                    NavigationLink(destination: SignOutView()) {
                        Text("Sign Out")
                        .font(Fonts.poppinsBody())
                        .onTapGesture {
                            DispatchQueue.global(qos: .background).async {
                                try? Auth.auth().signOut()
                            }
                            
                            withAnimation(.easeInOut) {
//                                logStatus = false
                                RootView()
                            }
                        }
//                    }
                    
                    
                }
            }
            
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text("Setting").font(Fonts.poppinsHeadline())
                }
            }
        }
        
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
