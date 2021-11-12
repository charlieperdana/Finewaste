//
//  MyContributionsView.swift
//  Finewaste
//
//  Created by Kendra Arsena W on 11/11/21.
//

import SwiftUI

struct MyContributionsView: View {
    @State var viewModel: MyContributionsViewModel
    
    var body: some View {
        VStack {
            Spacer().frame(height: 16)
            ForEach ($viewModel.contribution, id: \.viewModel.contributionID) { data in
                FinewasteContributionStatusCard(contribution: data)
            }
//            FinewasteContributionStatusCard(id: "", projectName: "Denim material for totebag", user: "Putri_240", createdDate: "26 October 2021, 19:05", dueDate: "28 October 2021", status: false)
//            FinewasteContributionStatusCard(id: "", projectName: "Denim material for totebag", user: "Putri_240", createdDate: "26 October 2021, 19:05", dueDate: "28 October 2021", status: true)
        }
    }
}

struct MyContributionsView_Previews: PreviewProvider {
    static var previews: some View {
        MyContributionsView()
    }
}
