//
//  HistoryProjectView.swift
//  Finewaste
//
//  Created by Kendra Arsena W on 19/11/21.
//

import SwiftUI

struct HistoryProjectView: View {
    @StateObject var viewModel = HistoryProjectsViewModel()
    
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
                    NavigationLink(destination: ContributionStatusDetailView(contributionId: contribution.id ?? "---")) {
                        FinewasteContributionStatusCard(contribution: contribution)
                    }
                }
            }
            
        }
    }
}

struct HistoryProjectView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryProjectView(viewModel: HistoryProjectsViewModel())
    }
}
