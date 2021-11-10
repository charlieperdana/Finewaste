//
//  FinewasteMaterialCard.swift
//  Finewaste
//
//  Created by Andrean Lay on 09/11/21.
//

import SwiftUI

struct FinewasteMaterialCard: View {
    @ObservedObject private var materialModel: NewContributionMaterialModel
    @State private var showEditMaterialModal = false
    
    init(model: NewContributionMaterialModel) {
        self._materialModel = ObservedObject(wrappedValue: model)
    }
    
    private var headerText: String {
        return materialModel.materialName
    }
    
    private var subheaderText: String {
        if materialModel.quantity == -1 {
            return materialModel.requirements.joined(separator: ", ")
        } else {
            return "\(materialModel.quantity) pcs"
        }
    }
    
    private var callToActionText: String {
        return materialModel.quantity == -1 ? "Add" : "Edit"
    }
    
    private var strokeColor: Color {
        return materialModel.quantity == -1 ? Colors.Gray : Colors.Turqoise
    }
    
    var body: some View {
        Group {
            HStack {
                VStack(alignment: .leading) {
                    Text(headerText)
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
        .contentShape(Rectangle())
        .onTapGesture {
            self.showEditMaterialModal = true
        }
        .sheet(isPresented: $showEditMaterialModal) {
            EditContributionMaterialView(model: materialModel)
        }
    }
}

struct FinewasteMaterialCard_Previews: PreviewProvider {
    static var previews: some View {
        FinewasteMaterialCard(model: NewContributionMaterialModel())
    }
}
