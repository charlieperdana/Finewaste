//
//  ContributionTimelineView.swift
//  Finewaste
//
//  Created by Andrean Lay on 11/11/21.
//

import SwiftUI

struct ContributionTimeline: View {    
    @ObservedObject private var viewModel: ContributionTimelineViewModel
    
    init(contribution: Contribution) {        
        self._viewModel = ObservedObject(wrappedValue: ContributionTimelineViewModel(contribution: contribution))
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            if viewModel.status < .waitingConfirmation {
                TimelineItem(header: viewModel.contributionRejectedHeaderText,
                             subheader: viewModel.contributionRejectedSubheaderText,
                             status: .current)
            } else {
                VStack {
                    TimelineConnector(isActive: viewModel.status < .finished)
                    TimelineConnector(isActive: viewModel.status < .deliveryConfirmed)
                }
                .offset(x: 8)
                
                VStack(alignment: .leading, spacing: 28) {
                    TimelineItem(header: viewModel.deliveryConfirmationHeaderText,
                                 subheader: viewModel.deliveryConfirmationSubheaderText,
                                 status: viewModel.deliveryConfirmationDotStatus)
                    
                    TimelineItem(header: viewModel.deliveryScheduleHeaderText,
                                 subheader: viewModel.deliveryScheduleSubheaderText,
                                 status: viewModel.deliveryScheduleDotStatus)
                    
                    TimelineItem(header: viewModel.confirmationHeaderText,
                                 subheader: viewModel.confirmationSubheaderText,
                                 status: viewModel.confirmationDotStatus)
                }
            }
        }
    }
}

struct ContributionTimeline_Previews: PreviewProvider {
    static var previews: some View {
        ContributionTimeline(contribution: Contribution())
    }
}
