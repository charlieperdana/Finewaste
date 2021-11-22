//
//  TimelineConnector.swift
//  Finewaste
//
//  Created by Andrean Lay on 11/11/21.
//

import SwiftUI

struct TimelineConnector: View {
    var isActive: Bool
    
    private var connectorColor: Color {
        isActive ? Colors.Pink : Colors.Gray
    }
    
    var body: some View {
        Rectangle()
            .frame(width: 2, height: 60)
            .foregroundColor(connectorColor)
            .opacity(0.7)
    }
}

struct TimelineConnector_Previews: PreviewProvider {
    static var previews: some View {
        TimelineConnector(isActive: false)
    }
}
