//
//  ProjectGridView.swift
//  Finewaste
//
//  Created by charlie siagian on 08/11/21.
//

import SwiftUI
import SDWebImageSwiftUI
import FirebaseFirestoreSwift
import FirebaseFirestore

struct ProjectGridView: View {
    
    @ObservedObject var model: ProjectViewModel
    @Binding var searchText : String
    
    var body: some View {
        LazyVGrid(columns: [
            GridItem(.flexible(minimum: 100, maximum: 200), spacing: 20, alignment: .top),
            GridItem(.flexible(minimum: 100, maximum: 200))

        ], alignment: .leading, spacing: 10, content: {
            ForEach((model.listProject).filter({"\($0)".contains(searchText) || searchText.isEmpty})){ project in
                NavigationLink(destination: ProjectDetailView(projectId: project.id ?? "---")) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(Colors.White)
                            .frame(width: 170, height: 260)
                            .shadow(color: Colors.DropShadow, radius: 2, x: 2, y: 1)
                        
                        
                        
                        VStack(alignment: .leading, spacing: 4) {
                            
                            WebImage(url: URL(string: (project.images?[0]) ?? ""))
                                .resizable()
                                .frame(width: 170, height: 170)
                                .scaledToFill()
                                .clipped()
                                .cornerRadius(10, corners: [.topLeft, .topRight])
                                .offset(y: 10)
                            
                            Text(project.projectName ?? "")  .font(Fonts.poppinsSubheadline())
                                .foregroundColor(Colors.DarkGray)
                                .fixedSize(horizontal: false, vertical: true)
                                .lineLimit(2)
                                .padding(5)
                                .offset(y: 5)
                            
                            
                            Spacer()
                            
                            
                            
                            VStack (alignment: .leading, spacing: 4){
                                
                                let contribution = (model.projectTarget[project.id ?? ""] ?? (contribution:0, target:0) ).contribution
                                
                                let target = (model.projectTarget[project.id ?? ""] ?? (contribution:0, target:0) ).target
                                
                                let progress = target - contribution
                                
                                let deadline = (model.daysToDeadline[project.id ?? ""] ?? 0 )
                                
                                
                                Text("\(progress) pcs more in \(deadline) days")
                                    .foregroundColor(Colors.Red)
                                    .font(Fonts.poppinsCaption())
                                
                                ProgressView(value: (Double(contribution)/Double(target)).isNaN ? 0 : Double(contribution)/Double(target), total: 1)
                                    .scaleEffect(x: 1, y: 1, anchor: .center)
                                    .accentColor(Colors.Red)
                                    .font(Fonts.poppinsCallout())
                            }.padding(8)
                                .offset(y: -15)
                            
                            
                        }
                        
                    }
                    .frame(width: 50, height: 50)
                    .padding(.vertical, 110)
                    .padding(.horizontal, 55)
                }
            }
            
        }).padding(.horizontal)
        
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
