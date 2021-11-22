//
//  ContributionDetail.swift
//  Finewaste
//
//  Created by Andrean Lay on 11/11/21.
//

import SwiftUI

struct ContributionDetail: View {
    private var requestSubmitDate = "---"
    private var deliveryType = "---"
    private var materials = [ContributionMaterial]()
    
    init(contribution: Contribution, materials: [ContributionMaterial]) {
        if let createdDate = contribution.createdDate {
            self.requestSubmitDate = TimestampHelper.shared.timestampToStringDate(timestamp: createdDate, format: .dateAndTime)
        }
        if let deliveryType = contribution.deliveryType {
            self.deliveryType = deliveryType
        }
        
        self.materials = materials
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Request Submit Date")
                    .font(Fonts.poppinsCallout())
                Text(requestSubmitDate)
                    .font(Fonts.poppinsSubheadline())
            }
            VStack(alignment: .leading, spacing: 8) {
                Text("Delivery Option")
                    .font(Fonts.poppinsCallout())
                Text(deliveryType)
                    .font(Fonts.poppinsSubheadline())
            }
            VStack(alignment: .leading, spacing: 8) {
                Text("Material Detail")
                    .font(Fonts.poppinsCallout())
                VStack(spacing: 40) {
                    ForEach(materials, id: \.id) { material in
                        ContributionMaterialItem(material: material)
                    }
                }
            }
        }
    }
}

struct ContributionDetail_Previews: PreviewProvider {
    static var previews: some View {
        ContributionDetail(contribution: Contribution(), materials: [])
    }
}
