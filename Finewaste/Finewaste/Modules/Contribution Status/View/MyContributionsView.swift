//
//  MyContributionsView.swift
//  Finewaste
//
//  Created by Kendra Arsena W on 11/11/21.
//

import SwiftUI

struct MyContributionsView: View {

    var body: some View {
        VStack {
            Spacer().frame(height: 16)
            FinewasteContributionStatusCard(id: "", projectName: "Denim material for totebag", user: "Putri_240", createdDate: "26 October 2021, 19:05", dueDate: "28 October 2021", status: false)
            FinewasteContributionStatusCard(id: "", projectName: "Denim material for totebag", user: "Putri_240", createdDate: "26 October 2021, 19:05", dueDate: "28 October 2021", status: true)
        }
    }
}

struct MyContributionsView_Previews: PreviewProvider {
    static var previews: some View {
        MyContributionsView()
    }
}
