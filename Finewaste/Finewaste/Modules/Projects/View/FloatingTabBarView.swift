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
        ZStack(alignment: .top) {
            HStack {
                VStack (spacing:5){
                    
                    Button(action: {
                        self.selected = 0
                        
                    }){
                        Image(systemName: "scissors")
                            .font(.system(size: 17, weight: .bold, design: .default))
                            .foregroundColor(self.selected == 0 ? Colors.Turqoise : Colors.DarkGray).padding(.horizontal)
                    }
                    Text("Projects").font(Fonts.poppinsCaption2()).foregroundColor(self.selected == 0 ? Colors.Turqoise : Colors.DarkGray)
                    
                }
                
                Spacer(minLength: 15)
                
                VStack (spacing:5){
                    
                    Button(action: {
                        self.selected = 1
                        
                    }){
                        Image(systemName: "bubble.left.and.bubble.right")
                            .font(.system(size: 17, weight: .bold, design: .default))
                            .foregroundColor(self.selected == 1 ? Colors.Turqoise : Colors.DarkGray).padding(.horizontal)
                    }
                    Text("Chat").font(Fonts.poppinsCaption2()).foregroundColor(self.selected == 1 ? Colors.Turqoise : Colors.DarkGray)
                }
                
                Spacer(minLength: 15)
                
                VStack(spacing:5) {
                    
                    Button(action: {
                        
                        self.selected = 2
                    }){
                        Image(systemName: "clock.arrow.circlepath")
                            .font(.system(size: 17, weight: .bold, design: .default))
                            .foregroundColor(self.selected == 2 ? Colors.Turqoise : Colors.DarkGray).padding(.horizontal)
                    }
                    Text("Status").font(Fonts.poppinsCaption2()).foregroundColor(self.selected == 2 ? Colors.Turqoise : Colors.DarkGray)
                }
                
                Spacer(minLength: 15)
                
                VStack(spacing:5) {
                    
                    Button(action: {
                        
                        self.selected = 3
                    }){
                        Image(systemName: "person.crop.circle")
                            .font(.system(size: 17, weight: .bold, design: .default))
                            .foregroundColor(self.selected == 3 ? Colors.Turqoise : Colors.DarkGray).padding(.horizontal)
                    }
                    Text("Profile").font(Fonts.poppinsCaption2()).foregroundColor(self.selected == 3 ? Colors.Turqoise : Colors.DarkGray)
                }
            }
            .padding(.top, 10)
            .padding(.horizontal, 20)
            
            Rectangle()
                .fill(Colors.PlaceholderGray)
                .frame(height: 1)
        }
        .padding(.bottom, 35)
        .background(Colors.White)
    }
}

struct FloatingTabBarView_Previews: PreviewProvider {
    @State static var selected = 0
    
    static var previews: some View {
        FloatingTabBarView(selected: $selected)
    }
}
