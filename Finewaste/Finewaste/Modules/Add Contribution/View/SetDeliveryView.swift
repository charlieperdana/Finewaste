//
//  SetDeliveryView.swift
//  Finewaste
//
//  Created by Andrean Lay on 09/11/21.
//

import SwiftUI

struct SetDeliveryView: View {
    @State private var selectedDeliveryMethod = ""
    
    @StateObject private var viewModel: SetDeliveryViewModel
    
    init(model: NewContributionModel) {
        self._viewModel = StateObject(wrappedValue: SetDeliveryViewModel(contributionModel: model))
        self._selectedDeliveryMethod = State(wrappedValue: model.deliveryType)
    }
    
    var body: some View {
        VStack(spacing: 26) {
            Spacer()
                .frame(height: 15)
            
            VStack(spacing: 20) {
                Text("Delivery Option")
                    .font(Fonts.poppinsCallout())
                    .frame(maxWidth: .infinity, alignment: .leading)
                FinewastePicker(placeholder: "Pick one of these options",
                                selectedData: $selectedDeliveryMethod,
                                dataToChoose: viewModel.deliveryTypes)
                    .onChange(of: selectedDeliveryMethod) { deliveryMethod in
                        viewModel.setContributionDeliveryMethod(method: deliveryMethod)
                    }
            }
            
            if !selectedDeliveryMethod.isEmpty {
                VStack(alignment: .leading, spacing: 8) {
                    Text("\(selectedDeliveryMethod.capitalized) Address")
                        .font(Fonts.poppinsCallout())
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    if selectedDeliveryMethod == "Drop off" {
                        FinewasteMapPicker(isReadOnly: true,
                                           currentAddress: .constant(viewModel.projectLocation),
                                           currentCoordinate: $viewModel.projectCoordinate)
                        Text("Deliver the materials within 3x24 hours from the time contribution request made")
                            .font(Fonts.poppinsCaption())
                    } else {
                        FinewasteMapPicker(isReadOnly: false,
                                           currentAddress: $viewModel.contributionModel.deliveryAddress,
                                           currentCoordinate: $viewModel.pickUpCoordinate)
                        Text("Materials will be picked up within 3x24 hours from the time contribution request made")
                            .font(Fonts.poppinsCaption())
                    }
                }
            }
        }
    }
}

struct SetDeliveryView_Previews: PreviewProvider {
    static var previews: some View {
        SetDeliveryView(model: NewContributionModel())
    }
}
