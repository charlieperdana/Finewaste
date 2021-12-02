//
//  FaqView.swift
//  Finewaste
//
//  Created by charlie siagian on 17/11/21.
//

import SwiftUI

struct FaqView: View {
    var body: some View {
        VStack {
            List(SettingContent.dataFaqSetting) { data in
                Section(header: Text(data.section.title)) {
                    ForEach(data.data as [SettingDataFaq], id: \.self){ item in
                        NavigationLink(destination: FaqItemView(title: item.title, content: item.content)) {
                            Text(item.title)
                                .font(Fonts.poppinsBody())
                                .foregroundColor(Colors.DarkGray)
                        }
                    }
                    
                    
                }
            }
            
        }
        .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Frequently Asked Questions").font(Fonts.poppinsHeadline())
                            .frame(width: 250)
                    }
                }
            }
    }
}

struct FaqView_Previews: PreviewProvider {
    static var previews: some View {
        FaqView()
    }
}
