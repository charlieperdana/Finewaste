//
//  MyProjectsView.swift
//  Finewaste
//
//  Created by Kendra Arsena W on 11/11/21.
//

import SwiftUI

struct MyProjectsView: View {
    @StateObject var viewModel = MyProjectsViewModel()
    
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
                    let status = ContributionStatus(from: contribution.status ?? -3)
                    
                    if status < .waitingConfirmation {
                        NavigationLink(destination: ContributionCancelView(cancelledBy: status == .projectOwnerReject ? .projectOwner : .wasteOwner, contribution: contribution)) {
                            FinewasteContributionStatusCard(contribution: contribution)
                        }
                    } else {
                        NavigationLink(destination: ContributionStatusDetailView(contributionId: contribution.id ?? "---")) {
                            FinewasteContributionStatusCard(contribution: contribution)
                        }
                    }
                }
            }
            
        }
    }
}

struct MyProjectsView_Previews: PreviewProvider {
    static var previews: some View {
        MyProjectsView(viewModel: MyProjectsViewModel())
    }
}
