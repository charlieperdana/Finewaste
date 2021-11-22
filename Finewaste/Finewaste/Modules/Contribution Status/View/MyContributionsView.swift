//
//  MyContributionsView.swift
//  Finewaste
//
//  Created by Kendra Arsena W on 11/11/21.
//

import SwiftUI

struct MyContributionsView: View {

    @StateObject var viewModel = MyContributionsViewModel()
    
    var body: some View {
        VStack {
            Spacer().frame(height: 16)
            if viewModel.contributions.isEmpty {
                Spacer()
                Text("No contribution yet")
                    .font(Fonts.poppinsCallout())
                    .foregroundColor(Colors.Gray)
                Spacer()
            } else {
                ForEach(viewModel.contributions, id: \.id) { contribution in
                    FinewasteContributionStatusCard(contribution: contribution)
                }
            }
        }
    }
}

struct MyContributionsView_Previews: PreviewProvider {
    static var previews: some View {
        MyContributionsView(viewModel: MyContributionsViewModel())
    }
}
