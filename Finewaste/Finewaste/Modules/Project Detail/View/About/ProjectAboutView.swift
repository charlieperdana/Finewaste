//
//  ProjectAboutView.swift
//  Finewaste
//
//  Created by Andrean Lay on 02/11/21.
//

import SwiftUI

struct ProjectAboutView: View {

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ProjectStoryView()
            ProjectMaterialRequirementView()
            VStack(alignment: .leading, spacing: 8) {
                Text("Location")
                    .font(Fonts.poppinsCallout())
                Text("Tanah Abang, Jakarta Pusat")
                    .font(Fonts.poppinsSubheadline())
            }
            VStack(alignment: .leading, spacing: 8) {
                Text("Delivery Option")
                    .font(Fonts.poppinsCallout())
                Text("Drop off")
                    .font(Fonts.poppinsSubheadline())
            }
        }
    }
}

struct ProjectAboutView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectAboutView()
    }
}
