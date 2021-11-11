//
//  FinewasteContributionStatusCard.swift
//  Finewaste
//
//  Created by Kendra Arsena W on 11/11/21.
//

import SwiftUI

struct FinewasteContributionStatusCard: View {
    var id: String
    var projectName: String
    var user: String
    var createdDate: String
    var dueDate: String
    var status: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(projectName)
                    .font(Fonts.poppinsCallout())
                Spacer()
                if !status {
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
                if status {
                    Text("Pick up on ")
                        .font(Fonts.poppinsCaption())
                        .foregroundColor(Colors.Turqoise)
                    Text(dueDate)
                        .font(Fonts.poppinsCaption())
                        .foregroundColor(Colors.Turqoise)
                        .bold()
                } else {
                    Text("Waiting confirmation until ")
                        .font(Fonts.poppinsCaption())
                        .foregroundColor(Colors.Red)
                    Text(dueDate)
                        .font(Fonts.poppinsCaption())
                        .foregroundColor(Colors.Red)
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
        FinewasteContributionStatusCard(id: "", projectName: "Denim material for totebag", user: "Putri_240", createdDate: "26 October 2021, 19:05", dueDate: "28 October 2021", status: true)
    }
}
