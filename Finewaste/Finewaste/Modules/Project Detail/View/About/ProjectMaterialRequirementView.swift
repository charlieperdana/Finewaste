//
//  ProjectMaterialRequirementView.swift
//  Finewaste
//
//  Created by Andrean Lay on 02/11/21.
//

import SwiftUI

struct ProjectMaterialRequirementView: View {
    private let dummyData = [
        "Denim": "No bleach stain",
        "Silk": "Clean"
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Material Requirements")
                .font(Fonts.poppinsCallout())
            Text("Clean, washed, no tear")
                .font(Fonts.poppinsFootnote())
            Divider()
            
            ForEach(Array(dummyData.keys), id: \.self) { key in
                Text(key)
                    .font(Fonts.poppinsSubheadline())
                Text(dummyData[key] ?? "No material requirement")
                    .font(Fonts.poppinsFootnote())
                Divider()
            }
        }
    }
}

struct ProjectMaterialRequirementView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectMaterialRequirementView()
    }
}
