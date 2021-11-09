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
    @Binding var listProject : [Project]
    
    @ObservedObject var model = ProjectViewModel()
    
    var body: some View {
        LazyVGrid(columns: [
            GridItem(.flexible(minimum: 100, maximum: 200), spacing: 20, alignment: .top),
            GridItem(.flexible(minimum: 100, maximum: 200))

        ], alignment: .leading, spacing: 12, content: {
            ForEach(listProject){ project in
                ZStack {
                    RoundedRectangle(cornerRadius: 10, style: .continuous).fill(Colors.White).shadow(color: Colors.DropShadow, radius: 2, x: 1, y: 1)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        
                        WebImage(url: URL(string: (project.images?[0]) ?? ""))
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(10, corners: [.topLeft, .topRight])
                        
//                        Text(project.projectName!)
                        Text(project.projectName ?? "")  .font(Fonts.poppinsSubheadline())
                            .foregroundColor(Colors.DarkGray).padding(5)
                        
                        Spacer()
                        
                    
                        
                        
                        VStack (alignment: .leading, spacing: 4){
                            
//                            let contribution = model.getNumberOfContribution(projectId: project.id ?? "")
//                            var contr = 0
//                            let needed = total - contribution
                            
                            let contribution = model.getProgesssOfContribution(projectId: project.id ?? "")
                            
//                            let needed = project.neededMaterials![1].target
                        
                            
                            Text("\(contribution) pcs more in 8 days")
                                .foregroundColor(Colors.Red)
                                .font(Fonts.poppinsCaption())
                            
                            ProgressView(value: 0.5, total: 1)
                                .scaleEffect(x: 1, y: 1, anchor: .center)
                                .accentColor(Colors.Red)
                                .font(Fonts.poppinsCallout())
                        }.padding(8)
                       
                        
                    }
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
    @State static var listProject = [Project(id: "", poster: "", projectName: "cinta", description: "", deadline: 0, neededMaterials: [ProjectMaterial()], images: [""], deliveryType: [""], location: GeoPoint(latitude: 0.0, longitude: 0.0), updates: [ProjectUpdate()])]
    static var previews: some View {
//        ProjectGridView(project: $project)
        ProjectGridView(listProject: $listProject)
    }
}
