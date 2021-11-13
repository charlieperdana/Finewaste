//
//  MyProfileView.swift
//  Finewaste
//
//  Created by charlie siagian on 13/11/21.
//

import SwiftUI

struct MyProfileView: View {
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                VStack(spacing:16) {
                    HeaderProfileView()
                    
                    InfoProfileView()
                    
                    FinewasteButtonFill(text: "Edit Profile", size: .fullWidth, isEnabled: true) {
                        print("Edit profile tapped")
                    }
                    
                    DescriptionProfileView()
                }
                
               
            }
            .padding()
            .navigationTitle(Text("").font(Fonts.poppinsTitle()))
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading:
                            HStack {
                Text("Charlie").font(Fonts.poppinsTitle())
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
}

struct MyProfileView_Previews: PreviewProvider {
    static var previews: some View {
        MyProfileView()
    }
}
