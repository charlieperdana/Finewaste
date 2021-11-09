//
//  FinewasteMaterialCard.swift
//  Finewaste
//
//  Created by Andrean Lay on 09/11/21.
//

import SwiftUI

struct FinewasteMaterialCard: View {
    private var materialName: String
    private var quantity: Int
    private var prerequisite: [String]
    
    init(contributionModel: NewContributionMaterialModel) {
        self.materialName = contributionModel.materialName
        self.prerequisite = contributionModel.requirements
        
        self.quantity = contributionModel.quantity
    }
    
    private var subheaderText: String {
        if quantity == -1 {
            return self.prerequisite.joined(separator: ", ")
        } else {
            return "\(quantity) pcs"
        }
    }
    
    private var callToActionText: String {
        return quantity == -1 ? "Add" : "Edit"
    }
    
    private var strokeColor: Color {
        return quantity == -1 ? Colors.Gray : Colors.Turqoise
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(materialName)
                    .font(Fonts.poppinsBody())
                Text(subheaderText)
                    .font(Fonts.poppinsCaption())
            }
            Spacer()
            Text(callToActionText)
                .font(Fonts.poppinsHeadline())
                .foregroundColor(Colors.Turqoise)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(strokeColor)
                .frame(height: 76)
        )
    }
}

struct FinewasteMaterialCard_Previews: PreviewProvider {
    static var previews: some View {
        FinewasteMaterialCard(contributionModel: NewContributionMaterialModel())
    }
}
