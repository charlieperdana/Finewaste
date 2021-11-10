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
    
    var index = 0
    
    var body: some View {
        LazyVGrid(columns: [
            GridItem(.flexible(minimum: 100, maximum: 200), spacing: 20, alignment: .top),
            GridItem(.flexible(minimum: 100, maximum: 200))
            
        ], alignment: .leading, spacing: 12, content: {
            ForEach((model.listProject).filter({"\($0)".contains(searchText) || searchText.isEmpty})){ project in
                ZStack {
                    RoundedRectangle(cornerRadius: 10, style: .continuous).fill(Colors.White).shadow(color: Colors.DropShadow, radius: 2, x: 2, y: 1)
                    
                    
                    VStack(alignment: .leading, spacing: 4) {
                        
                        WebImage(url: URL(string: (project.images?[0]) ?? ""))
                            .resizable()
                            .frame(width: 170, height: 170, alignment: .center)
                            .scaledToFill()
                            .clipped()
                            .cornerRadius(10, corners: [.topLeft, .topRight])
                        
                        Text(project.projectName ?? "")  .font(Fonts.poppinsSubheadline())
                            .foregroundColor(Colors.DarkGray)
                            .padding(5)
                            
                        
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
                        
                        
                    }
                    //                    .fixedSize()
                    
                }
                .fixedSize()
                //                .frame(maxHeight: 200)
                
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
//    @State static var listProject = [Project(id: "", poster: "", projectName: "cinta", description: "", deadline: 0, neededMaterials: [ProjectMaterial()], images: [""], deliveryType: [""], location: GeoPoint(latitude: 0.0, longitude: 0.0), updates: [ProjectUpdate()])]
    
    @State static var searchText = ""
    
    static var previews: some View {
        ProjectGridView(model: ProjectViewModel(),searchText: $searchText)
    }
}
