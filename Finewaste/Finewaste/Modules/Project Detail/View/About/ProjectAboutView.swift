//
//  ProjectAboutView.swift
//  Finewaste
//
//  Created by Andrean Lay on 02/11/21.
//

import SwiftUI

struct ProjectAboutView: View {
    @ObservedObject var viewModel: ProjectDetailViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ProjectStoryView(projectDesc: viewModel.project?.description ?? "---")
            ProjectMaterialRequirementView(materials: viewModel.projectMaterials)
            VStack(alignment: .leading, spacing: 8) {
                Text("Location")
                    .font(Fonts.poppinsCallout())
                Text(viewModel.projectLocation)
                    .font(Fonts.poppinsSubheadline())
            }
            VStack(alignment: .leading, spacing: 8) {
                Text("Delivery Option")
                    .font(Fonts.poppinsCallout())
                Text(viewModel.getDeliveryTypes())
                    .font(Fonts.poppinsSubheadline())
            }
        }
    }
}

struct ProjectAboutView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectAboutView(viewModel: ProjectDetailViewModel(projectId: ""))
    }
}
