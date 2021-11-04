//
//  ProjectDescriptionView.swift
//  Finewaste
//
//  Created by Andrean Lay on 03/11/21.
//

import SwiftUI

struct ProjectDescriptionView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Totebag Project")
                    .font(Fonts.poppinsTitle2())
                    .padding(.top)
                Text("Target 3000 pcs")
                    .font(Fonts.poppinsCallout())
            }
            ProgressView(value: 0.7, total: 1)
                .scaleEffect(x: 1, y: 2, anchor: .center)
                .accentColor(Colors.Red)
                .font(Fonts.poppinsCallout())
            HStack {
                Text("100 contributors")
                Spacer()
                Text("2800 pcs more in 20 days")
                    .foregroundColor(Colors.Red)
            }
            .font(Fonts.poppinsCallout())
            
            ProjectContentView()
            
            // Add empty space to accomodate floating contribute button
            // The distance from last text to button is 32
            // The button size is 44
            // Thus by adding them, we need 32 + 44 = 76px to get desired result
            Spacer()
                .frame(height: 76)
        }
        .padding([.leading, .trailing])
    }
}

struct ProjectDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectDescriptionView()
    }
}
