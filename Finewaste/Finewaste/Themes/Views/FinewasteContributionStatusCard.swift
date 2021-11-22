//
//  FinewasteContributionStatusCard.swift
//  Finewaste
//
//  Created by Kendra Arsena W on 11/11/21.
//

import SwiftUI
import FirebaseFirestore

struct FinewasteContributionStatusCard: View {
    var id: String
    var projectName: String
    var user: String
    var createdDate: String
    var dueDate: String = ""
    var status: Int
    
//    @StateObject var viewModel: MyContributionsViewModel
    
    init(contribution: Contribution) {
        self.id = contribution.id ?? ""
        self.projectName = contribution.projectName ?? ""
        self.user = contribution.contributorId ?? ""
        self.createdDate = TimestampHelper.shared.timestampToStringDate(timestamp: contribution.createdDate ?? Timestamp(seconds: 0, nanoseconds: 0), format: .dateAndTime)
        if let createdDateTimestamp = contribution.createdDate {
            let dueDateInThreeDays = Timestamp(seconds: Int64(createdDateTimestamp.seconds + 259200), nanoseconds: 0)
            self.dueDate = TimestampHelper.shared.timestampToStringDate(timestamp: dueDateInThreeDays, format: .simple)
        }
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
            HStack(spacing: 0) {
                if status == 0 {
                    Text("Waiting confirmation until ")
                        .font(Fonts.poppinsCaption())
                        .foregroundColor(Colors.Red)
                    Text(dueDate)
                        .font(Fonts.poppinsCaption())
                        .foregroundColor(Colors.Red)
                        .bold()
                } else {
                    Text("Pick up on ")
                        .font(Fonts.poppinsCaption())
                        .foregroundColor(Colors.Turqoise)
                    Text(dueDate)
                        .font(Fonts.poppinsCaption())
                        .foregroundColor(Colors.Turqoise)
                        .bold()
                }
                Spacer()
            }
        }
        .padding()
        .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(Colors.Gray, lineWidth: 1))
    }
}

struct FinewasteContributionStatusCard_Previews: PreviewProvider {
    static var previews: some View {
        FinewasteContributionStatusCard(contribution: Contribution())
    }
}
