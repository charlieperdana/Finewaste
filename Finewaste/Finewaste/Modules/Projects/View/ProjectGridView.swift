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
//    @Binding var project : Project
    
    var body: some View {
        LazyVGrid(columns: [
            GridItem(.flexible(minimum: 100, maximum: 200),spacing: 20, alignment: .top),
            GridItem(.flexible(minimum: 100, maximum: 200))

        ], alignment: .leading, spacing: 12, content: {
            ForEach(0..<20, id: \.self){ num in
                ZStack {
                    RoundedRectangle(cornerRadius: 10, style: .continuous).fill(Colors.White).shadow(color: Colors.DropShadow, radius: 2, x: 1, y: 1)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        
                        WebImage(url: URL(string: "https://i.ibb.co/0jWhy2D/Project-1-Image.png"))
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(10, corners: [.topLeft, .topRight])
                        
//                        Text(project.projectName!)
                        Text("Totebag Project")  .font(Fonts.poppinsSubheadline())
                            .foregroundColor(Colors.DarkGray).padding(5)
                        
                        Spacer()
                        
                    
                        
                        
                        VStack (alignment: .leading, spacing: 4){
                            
                         
                            
                            Text("80 pcs more in 8 days")
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
    @State static var project = Project(id: "", poster: "", projectName: "cinta", description: "", deadline: 0, neededMaterials: [ProjectMaterial()], images: [""], deliveryType: [""], location: GeoPoint(latitude: 0.0, longitude: 0.0), updates: [ProjectUpdate()])
    static var previews: some View {
//        ProjectGridView(project: $project)
        ProjectGridView()
    }
}
