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
        ZStack {
            VStack(alignment: .leading, spacing: 4) {
                KFImage(URL(string: (project.images?[0]) ?? ""))
                    .downsampling(size: CGSize(width: 250, height: 250))
                    .centerWidthCrop()
                    .frame(width: 170, height: 170)
                    .cornerRadius(10, corners: [.topLeft, .topRight])
                
                Text(project.projectName ?? "")  .font(Fonts.poppinsSubheadline())
                    .foregroundColor(Colors.DarkGray)
                    .fixedSize(horizontal: false, vertical: true)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .padding(5)
                    .offset(y: 5)
                    .frame(alignment: .leading)
                
                
                Spacer()
                
                VStack (alignment: .leading, spacing: 4){
                    
                    let contribution = (model.projectTarget[project.id ?? ""] ?? (contribution:0, target:0) ).contribution
                    
                    let target = (model.projectTarget[project.id ?? ""] ?? (contribution:0, target:0) ).target
                    
                    let progress = target - contribution
                    
                    let deadline = (model.daysToDeadline[project.id ?? ""] ?? 0 )
                    
                    
                    Text("\(progress) pcs more in \(deadline) days")
                        .foregroundColor(Colors.Red)
                        .font(Fonts.poppinsCaption())
                        .multilineTextAlignment(.leading)
                    
                    ProgressView(value: (Double(contribution)/Double(target)).isNaN ? 0 : Double(contribution)/Double(target), total: 1)
                        .scaleEffect(x: 1, y: 1, anchor: .center)
                        .accentColor(Colors.Red)
                        .font(Fonts.poppinsCallout())
                }.padding(8)
                    .offset(y: -15)
            }            
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .stroke(Colors.DropShadow, lineWidth: 1)
//                .frame(width: 170, height: 275)
        }
        .frame(width: 50, height: 50)
//        .modifier(CardShadow())
        .padding(.vertical, 110)
        .padding(.horizontal, 55)
    }
}

struct ProjectCard_Previews: PreviewProvider {
    static var previews: some View {
        ProjectCard(project: Project(), viewModel: ProjectViewModel())
    }
}
