//
//  ProjectUpdateView.swift
//  Finewaste
//
//  Created by Andrean Lay on 02/11/21.
//

import SwiftUI

struct ProjectUpdateView: View {
    @StateObject private var viewModel: ProjectUpdateViewModel
    
    init(projectId: String) {
        _viewModel = StateObject(wrappedValue: ProjectUpdateViewModel(projectId: projectId))
    }
    
    var body: some View {
        VStack(spacing: 16) {
            ForEach(viewModel.projectUpdates, id: \.id) { update in
                ZStack {
                    ProjectUpdateCard(update: update)
                }
            }
        }
    }
}

struct ProjectUpdateView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectUpdateView(projectId: "")
    }
}
