//
//  FloatingTabBarView.swift
//  Finewaste
//
//  Created by charlie siagian on 07/11/21.
//

import SwiftUI

struct FloatingTabBarView: View {
    @Binding var selected : Int
    var body: some View {
        HStack {
            VStack (spacing:5){
                
                Button(action: {
                    self.selected = 0
                   
                }){
                    Image(systemName: "scissors").foregroundColor(self.selected == 0 ? Colors.Turqoise : Colors.DarkGray).padding(.horizontal)
                }
                Text("Projects").font(Fonts.poppinsCaption2()).foregroundColor(self.selected == 0 ? Colors.Turqoise : Colors.DarkGray)
                
            }
            
            Spacer(minLength: 15)
            
            VStack (spacing:5){
                
                Button(action: {
                    self.selected = 1
                   
                }){
                    Image(systemName: "bubble.left.and.bubble.right").foregroundColor(self.selected == 1 ? Colors.Turqoise : Colors.DarkGray).padding(.horizontal)
            }
                Text("Chat").font(Fonts.poppinsCaption2()).foregroundColor(self.selected == 1 ? Colors.Turqoise : Colors.DarkGray)
            }
            
            Spacer(minLength: 15)
            
            VStack(spacing:5) {
                
                Button(action: {
                    
                    self.selected = 2
                }){
                    Image(systemName: "clock.arrow.circlepath").foregroundColor(self.selected == 2 ? Colors.Turqoise : Colors.DarkGray).padding(.horizontal)
            }
                Text("Status").font(Fonts.poppinsCaption2()).foregroundColor(self.selected == 2 ? Colors.Turqoise : Colors.DarkGray)
            }
            
            Spacer(minLength: 15)
            
            VStack(spacing:5) {
                
                Button(action: {
                   
                    self.selected = 3
                }){
                    Image(systemName: "person.crop.circle").foregroundColor(self.selected == 3 ? Colors.Turqoise : Colors.DarkGray).padding(.horizontal)
            }
                Text("Profile").font(Fonts.poppinsCaption2()).foregroundColor(self.selected == 3 ? Colors.Turqoise : Colors.DarkGray)
            }
        }
        .padding(.vertical, 5)
        .padding(.horizontal, 20)
        .background(Colors.White)
//        .clipShape(Capsule())
    }
}

struct FloatingTabBarView_Previews: PreviewProvider {
    @State static var selected = 0
    
    static var previews: some View {
        FloatingTabBarView(selected: $selected)
    }
}
