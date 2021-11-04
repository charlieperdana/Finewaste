//
//  ProjectNavigationBar.swift
//  Finewaste
//
//  Created by Andrean Lay on 02/11/21.
//

import SwiftUI

struct ProjectNavigationBar: View {
    @Environment(\.presentationMode) var presentationMode
    var navBarOpacity: Double

    var body: some View {
        ZStack(alignment: .bottom) {
            Color.white
                .frame(height: 86)
                .opacity(navBarOpacity)
            HStack {
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    ZStack {
                        Circle()
                            .fill(Colors.Gray)
                            .frame(width: 44, height: 44)
                            .opacity(min(0.4, 1 - navBarOpacity))
                        Image(systemName: "chevron.backward")
                            .foregroundColor(Colors.Turqoise)
                            .font(.system(size: 23))
                    }
                }
                .offset(x: -15 * navBarOpacity, y: -3 * navBarOpacity)
                Spacer()
            }
            .padding(.top)
            .padding(.leading, 16)
        }
    }
}

struct ProjectNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        ProjectNavigationBar(navBarOpacity: 1.0)
    }
}
