//
//  ProjectStatusView.swift
//  Finewaste
//
//  Created by Andrean Lay on 03/11/21.
//

import SwiftUI

struct ProjectStatusView: View {
    @StateObject var viewModel: ProjectStatusViewModel
    
    
    init(project: Project) {
        _viewModel = StateObject(wrappedValue: ProjectStatusViewModel(project: project))
    }
    
    var body: some View {
        Group {
            Text("Target \(viewModel.totalMaterialQuantity) pcs")
                .font(Fonts.poppinsCallout())
            ProgressView(
                value: Double(viewModel.contributedQuantity) / Double(viewModel.totalMaterialQuantity),
                total: 1)
                .scaleEffect(x: 1, y: 2, anchor: .center)
                .accentColor(Colors.Red)
                .font(Fonts.poppinsCallout())
                .animation(.linear)
            HStack {
                Text("\(viewModel.contributorsQuantity) contributors")
                Spacer()
                Text("\(viewModel.materialsNeededToMeetTarget) pcs more in \(viewModel.daysToDeadline) days")
                    .foregroundColor(Colors.Red)
            }
            .font(Fonts.poppinsCallout())
        }
    }
}

struct ProjectStatusView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectStatusView(project: Project())
    }
}
