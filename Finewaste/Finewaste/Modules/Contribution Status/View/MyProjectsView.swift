//
//  MyProjectsView.swift
//  Finewaste
//
//  Created by Kendra Arsena W on 11/11/21.
//

import SwiftUI

struct MyProjectsView: View {
    var body: some View {
        Spacer()
        Text("No contribution yet")
            .font(Fonts.poppinsCallout())
            .foregroundColor(Colors.Gray)
        Spacer()
    }
}

struct MyProjectsView_Previews: PreviewProvider {
    static var previews: some View {
        MyProjectsView()
    }
}
