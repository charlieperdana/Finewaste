//
//  ProjectUpdateView.swift
//  Finewaste
//
//  Created by Andrean Lay on 02/11/21.
//

import SwiftUI

struct ProjectUpdateView: View {
    var body: some View {
        VStack(spacing: 16) {
            ForEach(0..<2) { _ in
                ZStack {
                    ProjectUpdateCard()
                    
                }
            }
        }
    }
}

struct ProjectUpdateView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectUpdateView()
    }
}
