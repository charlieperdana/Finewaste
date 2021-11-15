//
//  MyProfileView.swift
//  Finewaste
//
//  Created by charlie siagian on 13/11/21.
//

import SwiftUI

struct MyProfileView: View {
    @StateObject var model = ProfileViewModel(userId: "8xayV4ivOsOSqUrNiD0kOHM7jih1")
    
    @State var showEditPage = false
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing:16) {
                HeaderProfileView(model: model)
                
                InfoProfileView(model: model)
                
                FinewasteButtonFill(text: "Edit Profile", size: .fullWidth, isEnabled: true) {
                    self.showEditPage = true
                }
                
                NavigationLink(destination: EditProfileView(), isActive: $showEditPage) {}
                
                DescriptionProfileView(model: model)
            }
            
            
        }
        .padding()
        .navigationTitle(Text("").font(Fonts.poppinsTitle()))
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(leading:
                                HStack {
            Text(model.user.username ?? "---").font(Fonts.poppinsTitle())
        }
        )
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    
                } label: {
                    Image(systemName: "gearshape").foregroundColor(Colors.Turqoise)
                }
                
                
            }
        }
    }
}

struct MyProfileView_Previews: PreviewProvider {
    static var previews: some View {
        MyProfileView()
    }
}
