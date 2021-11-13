//
//  HeaderProfileView.swift
//  Finewaste
//
//  Created by charlie siagian on 13/11/21.
//

import SDWebImageSwiftUI

import SwiftUI

struct HeaderProfileView: View {
    var body: some View {
        VStack {
            HStack {
                WebImage(url: URL(string: ("https://firebasestorage.googleapis.com/v0/b/finewaste.appspot.com/o/Profile%20Pic.svg?alt=media&token=63062364-4414-4d84-bb83-7a766f4aaa57")))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .overlay(Circle().strokeBorder(Color.orange, lineWidth: 2))
                
                VStack(spacing:12){
                    HStack {
                        Spacer()
                        VStack {
                            Text("4300")
                                .font(Fonts.poppinsTitle())
                            Text("pcs saved")
                                .font(Fonts.poppinsFootnote())
                        }
                        Spacer()
                        VStack {
                            Text("4300")
                                .font(Fonts.poppinsTitle())
                            Text("projects")
                                .font(Fonts.poppinsFootnote())
                        }
                        Spacer()
                        VStack {
                            Text("4300")
                                .font(Fonts.poppinsTitle())
                            Text("contributed")
                                .font(Fonts.poppinsFootnote())
                        }
                        
                    }
                    
                    
                }
                    
            }
            
        
        
        
        }
    }
}

struct HeaderProfileView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderProfileView()
    }
}
