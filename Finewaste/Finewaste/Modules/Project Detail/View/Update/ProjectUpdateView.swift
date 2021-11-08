//
//  ProjectUpdateView.swift
//  Finewaste
//
//  Created by Andrean Lay on 02/11/21.
//

import SwiftUI

struct ProjectUpdateView: View {
    @StateObject private var viewModel: ProjectUpdateViewModel
    @State private var isShowingPostUpdateModal = false
    
    init(projectId: String) {
        _viewModel = StateObject(wrappedValue: ProjectUpdateViewModel(projectId: projectId))
    }
    
    var body: some View {
        VStack(spacing: 16) {
            FinewasteButtonOutline(text: "Post Update", size: .fullWidth, isEnabled: true) {
                isShowingPostUpdateModal = true
            }
            
            ForEach(viewModel.projectUpdates, id: \.id) { update in
                ZStack {
                    ProjectUpdateCard(update: update)
                }
            }
        }
        .sheet(isPresented: $isShowingPostUpdateModal) {
            PostProjectUpdateView(projectId: viewModel.projectId)
        }
    }
}

struct ProjectUpdateView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectUpdateView(projectId: "")
    }
}
