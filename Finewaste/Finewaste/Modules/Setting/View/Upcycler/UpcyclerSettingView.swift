//
//  UpcyclerSettingView.swift
//  Finewaste
//
//  Created by charlie siagian on 24/11/21.
//

import SwiftUI

struct UpcyclerSettingView: View {
    
    var body: some View {
        ScrollView {
            VStack() {
                ForEach(SettingContent.dataUpcycler as [SettingDataChild], id: \.self){ data in
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text(data.title)
                            .font(Fonts.poppinsHeadline())
                        Image(data.image)
                        Text(data.desc)
                            .font(Fonts.poppinsSubheadline())
                    }.padding(.bottom, 12)
                    
               
                }
                
                
                
            }.padding()
            
            .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        VStack {
                            Text("I'm an upcycler").font(Fonts.poppinsHeadline())
                                .frame(width: 200)
                        }
                    }
            }
        }
    }
}

struct UpcyclerSettingView_Previews: PreviewProvider {
    static var previews: some View {
        UpcyclerSettingView()
    }
}


