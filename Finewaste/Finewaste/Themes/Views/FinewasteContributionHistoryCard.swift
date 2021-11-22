//
//  FinewasteContributionHistoryCard.swift
//  Finewaste
//
//  Created by Kendra Arsena W on 22/11/21.
//

import SwiftUI
import FirebaseFirestore

struct FinewasteContributionHistoryCard: View {
    var id: String
    var projectName: String
    var user: String
    var createdDate: String
    var status: Int
    
    init(contribution: Contribution) {
        self.id = contribution.id ?? ""
        self.projectName = contribution.projectName ?? ""
        self.user = contribution.contributorId ?? ""
        self.createdDate = TimestampHelper.shared.timestampToStringDate(timestamp: contribution.createdDate ?? Timestamp(seconds: 0, nanoseconds: 0), format: .dateAndTime)
        self.status = contribution.status ?? 0
    }
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(projectName)
                    .font(Fonts.poppinsCallout())
                Spacer()
                if status == 0 {
                    Image(systemName: "circle.fill")
                        .foregroundColor(Colors.Red)
                        .frame(width: 15, height: 15)
                }
            }
            Spacer().frame(height: 0)
            HStack {
                Text(user)
                    .font(Fonts.poppinsCaption())
                Circle().frame(width: 4, height: 4)
                Text(createdDate)
                    .font(Fonts.poppinsCaption())
            }
            Spacer().frame(height: 16)
            Text("Contribution Rejected")
                .font(Fonts.poppinsCaption())
                .foregroundColor(Colors.Turqoise)
        }
        .padding()
        .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(Colors.Gray, lineWidth: 1))
    }
}

struct FinewasteContributionHistoryCard_Previews: PreviewProvider {
    static var previews: some View {
        FinewasteContributionHistoryCard(contribution: Contribution())
    }
}
