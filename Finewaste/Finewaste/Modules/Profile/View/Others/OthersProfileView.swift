//
//  OthersProfileView.swift
//  Finewaste
//
//  Created by charlie siagian on 23/11/21.
//

import SwiftUI

struct OthersProfileView: View {
    @StateObject var model = ProfileViewModel(userId: "8xayV4ivOsOSqUrNiD0kOHM7jih1")
    
    @State var showChatPage = false
    @State var showSettingPage = false
    
    @State var isGuest = false
    
    init(userId:String){
        self._model = StateObject(wrappedValue: ProfileViewModel(userId: userId))
    }
    
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 8){
                HeaderProfileView(model: model, isGuest: $isGuest)
                
                InfoProfileView(model: model)
                
                FinewasteButtonFill(text: "Chat", size: .fullWidth, isEnabled: true) {
                    self.showChatPage = false
                }
                
                
                DescriptionProfileView(model: model)
                

                ProductInfoProfileView(model: model)
                
                
                NavigationLink(destination: EditProfileView(model: model), isActive: $showChatPage) {}
                
                NavigationLink(destination: SettingView(), isActive: $showSettingPage) {}
                
                
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("\(model.user.username ?? "xxx")").font(Fonts.poppinsHeadline())
                            .frame(width: 100)
                    }
                }
            }
            
        }
        
        
        
    }
}

struct OthersProfileView_Previews: PreviewProvider {
    static var previews: some View {
        OthersProfileView(userId: "8xayV4ivOsOSqUrNiD0kOHM7jih1")
    }
}
