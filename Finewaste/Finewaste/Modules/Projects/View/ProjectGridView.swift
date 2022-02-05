//
//  ProjectGridView.swift
//  Finewaste
//
//  Created by charlie siagian on 08/11/21.
//

import SwiftUI

struct ProjectGridView: View {
    
    @ObservedObject var model: ProjectViewModel
    @Binding var searchText : String
    
    var body: some View {
        Group {
            LazyVGrid(columns: [
                GridItem(.flexible(minimum: 100, maximum: 200), spacing: 20, alignment: .top),
                GridItem(.flexible(minimum: 100, maximum: 200))

            ], alignment: .leading, spacing: 25, content: {
                ForEach((model.listProject).filter({"\($0)".contains(searchText) || searchText.isEmpty})){ project in
                    NavigationLink(destination: ProjectDetailView(projectId: project.id ?? "---")) {
                        ProjectCard(project: project, viewModel: model)
                    }
                }


            })
            .padding(.horizontal)
            
            Spacer()
                .frame(height: 100)
        }
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct ProjectGridView_Previews: PreviewProvider {

    @State static var searchText = ""
    
    static var previews: some View {
        ProjectGridView(model: ProjectViewModel(),searchText: $searchText)
    }
}
