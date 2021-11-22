//
//  ContributionCancelView.swift
//  Finewaste
//
//  Created by Andrean Lay on 16/11/21.
//

import SwiftUI

enum CancellationSide: String {
    case wasteOwner = "cancelled"
    case projectOwner = "rejected"
}

struct ContributionCancelView: View {
    var cancelledBy: CancellationSide
    
    private var headerText: String {
        cancelledBy == .wasteOwner ? "Contribution Cancelled" : "Contribution Rejected"
    }
    
    private var subheaderText: String {
        "Sorry, your contribution was \(cancelledBy.rawValue) \n because:"
    }
    
    var body: some View {
        VStack(spacing: 38.35) {
            Spacer()
                .frame(height: 55)
            
            Image("contributionCancelled")
                .resizable()
                .frame(width: 220, height: 220)
            
            VStack(spacing: 22) {
                Text(headerText)
                    .foregroundColor(Colors.Turqoise)
                    .font(Fonts.poppinsTitle())
                Text(subheaderText)
                    .font(Fonts.poppinsBody())
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                VStack(spacing: 4) {
                    Text("Materials does not meet the requirements")
                        .font(Fonts.poppinsBody())
                    Rectangle()
                        .fill(Colors.PlaceholderGray)
                        .frame(height: 1)
                }
            }
            
            Spacer()

            FinewasteButtonFill(text: "Back to Contribution Status", size: .fullWidth, isEnabled: true) {

            }
        }
        .padding(.horizontal)
    }
}

struct ContributionCancelView_Previews: PreviewProvider {
    static var previews: some View {
        ContributionCancelView(cancelledBy: .wasteOwner)
    }
}
