//
//  SelectMaterialView.swift
//  Finewaste
//
//  Created by Andrean Lay on 09/11/21.
//

import SwiftUI

struct SelectMaterialView: View {
    @StateObject var viewModel: SelectMaterialViewModel
    
    @State private var showEditMaterialModal = false
    
    init(model: NewContributionModel) {
        self._viewModel = StateObject(wrappedValue: SelectMaterialViewModel(contributionModel: model))
    }
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 40)
            if viewModel.contributionModel.materials.isEmpty {
                Text("Fetching project material..")
                    .font(Fonts.poppinsSubheadline())
            } else {
                VStack(spacing: 16) {
                    ForEach(viewModel.contributionModel.materials, id: \.materialId) { material in
                        FinewasteMaterialCard(model: material)
                    }
                }
            }
        }
    }
}

struct SelectMaterialView_Previews: PreviewProvider {
    static var previews: some View {
        SelectMaterialView(model: NewContributionModel())
    }
}
