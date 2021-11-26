//
//  ProjectMaterialRequirementView.swift
//  Finewaste
//
//  Created by Andrean Lay on 02/11/21.
//

import SwiftUI

struct ProjectMaterialRequirementView: View {
    private var specificRequirement = [String: [String]]()
    private var generalRequirement = [String]()
    
    init(materials: [ProjectMaterial]) {
        // Step 1: Fetch all requirement from all materials
        var allRequirements = [String]()
        for material in materials {
            material.prerequisite.flatMap { allRequirements.append(contentsOf: $0) }
            specificRequirement[material.name ?? "---"] = []
        }
        
        // Step 2: Count each requirement, if each materials have the same requirement,
        //         append it to general requirement.
        var counter = [String: Int]()
        for requirement in allRequirements {
            counter[requirement] = (counter[requirement] ?? 0 ) + 1
            
            if let count = counter[requirement], count == materials.count {
                generalRequirement.append(requirement)
            }
        }
        
        // Step 3: Find the specific requirement for each materials
        for material in materials {
            material.prerequisite?.forEach { requirement in
                if !self.generalRequirement.contains(requirement) {
                    specificRequirement[material.name ?? "---"]?.append(requirement)
                }
            }
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Material Requirements")
                .font(Fonts.poppinsCallout())
            if !generalRequirement.isEmpty {
                Text(generalRequirement.joined(separator: ", "))
                    .font(Fonts.poppinsFootnote())
            }
            Divider()
                .background(Colors.Separator)
            
            ForEach(Array(specificRequirement.keys), id: \.self) { name in
                Text(name)
                    .font(Fonts.poppinsSubheadline())
                Text(specificRequirement[name]?.joined(separator: ", ") ?? "No material requirement")
                    .font(Fonts.poppinsFootnote())
                Divider()
                    .background(Colors.Separator)
            }
        }
    }
}

struct ProjectMaterialRequirementView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectMaterialRequirementView(materials: [])
    }
}
