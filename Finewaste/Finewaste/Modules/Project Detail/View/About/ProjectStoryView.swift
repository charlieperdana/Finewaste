//
//  ProjectStoryView.swift
//  Finewaste
//
//  Created by Andrean Lay on 02/11/21.
//

import SwiftUI

struct ProjectStoryView: View {
    @State private var lineLimit = 3
    private var buttonText: String {
        lineLimit == 3 ? "Read More" : "Read Less"
    }
    private var projectDesc = """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Amet nisl suscipit adipiscing bibendum est ultricies.
        Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Amet nisl suscipit adipiscing bibendum est ultricies.
        Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et.
        """
    
    
    var body: some View {
        Group {
            Text("Project Story")
                .font(Fonts.poppinsCallout())
            Text(projectDesc)
                .font(Fonts.poppinsSubheadline())
                .lineLimit(lineLimit)
            
            FinewasteOutlineButton(
                text: buttonText,
                size: .fullWidth) {
                    
                    withAnimation {
                        if lineLimit == 3 {
                            lineLimit = 100
                        } else {
                            lineLimit = 3
                        }
                    }
                }
            
            Divider()
        }
    }
}

struct ProjectStoryView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectStoryView()
    }
}
