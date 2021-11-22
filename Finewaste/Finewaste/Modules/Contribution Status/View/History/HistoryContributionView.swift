//
//  HistoryContributionView.swift
//  Finewaste
//
//  Created by Kendra Arsena W on 19/11/21.
//

import SwiftUI

struct HistoryContributionView: View {
    @StateObject var viewModel = HistoryContributionsViewModel()
    
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
                    FinewasteContributionHistoryCard(contribution: contribution)
                }
            }
        }
    }
}

struct HistoryContributionView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryContributionView()
    }
}
