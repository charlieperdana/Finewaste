//
//  ProjectCard.swift
//  Finewaste
//
//  Created by Andrean Lay on 24/01/22.
//

import SwiftUI
import Kingfisher

struct ProjectCard: View {
    private var project: Project
    @ObservedObject var model: ProjectViewModel
    
    init(project: Project, viewModel: ProjectViewModel) {
        self.project = project
        self.model = viewModel
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Image("ShadowCard")
                .resizable()
                .frame(width: 170, height: 260)
            
            VStack(spacing: 8) {
                KFImage(URL(string: (project.images?[0]) ?? ""))
                    .downsampling(size: CGSize(width: 250, height: 250))
                    .centerWidthCrop(width: 159, height: 159)
                    .frame(width: 159, height: 159)
                    .cornerRadius(10, corners: [.topLeft, .topRight])
                
                Group {
                    Text(project.projectName ?? "")
                        .font(Fonts.poppinsSubheadline())
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .fixedSize(horizontal: false, vertical: true)
                        .frame(height: 25)
                        .offset(y: 5)
                    
                    VStack (alignment: .leading, spacing: 4){
                        
                        let contribution = (model.projectTarget[project.id ?? ""] ?? (contribution:0, target:0) ).contribution
                        
                        let target = (model.projectTarget[project.id ?? ""] ?? (contribution:0, target:0) ).target
                        
                        let progress = target - contribution
                        
                        let deadline = (model.daysToDeadline[project.id ?? ""] ?? 0 )
                        
                        
                        Text("\(progress) pcs more in \(deadline) days")
                            .foregroundColor(Colors.Red)
                            .font(Fonts.poppinsCaption())
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(height: 15)
                        
                        ProgressView(value: (Double(contribution)/Double(target)).isNaN ? 0 : Double(contribution)/Double(target), total: 1)
                            .scaleEffect(x: 1, y: 1, anchor: .center)
                            .accentColor(Colors.Red)
                            .font(Fonts.poppinsCallout())
                            .offset(y: 6)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
        }
        .frame(width: 170, height: 260)
    }
}

struct ProjectCard_Previews: PreviewProvider {
    static var previews: some View {
        ProjectCard(project: Project(), viewModel: ProjectViewModel())
    }
}
