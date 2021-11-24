//
//  TimelineItem.swift
//  Finewaste
//
//  Created by Andrean Lay on 11/11/21.
//

import SwiftUI

enum TimelineStatus {
    case completed
    case current
    case incoming
}

struct TimelineItem: View {
    var header: String
    var subheader: String
    var status: TimelineStatus
    
    private var indicatorColor: Color {
        switch status {
        case .completed:
            return Colors.Gray
        case .incoming:
            return Colors.Pink
        case .current:
            return Colors.Red
        default:
            return Color.clear
        }
    }
    
    private var headerFont: Font {
        status == .current ? Fonts.poppinsSubheadlineBold() : Fonts.poppinsSubheadline()
    }
    
    var body: some View {
        HStack(spacing: 36) {
            Image(systemName: "circle.fill")
                .foregroundColor(indicatorColor)
                .font(Fonts.poppinsSubheadline())
            VStack(alignment: .leading) {
                Text(header)
                    .font(headerFont)
                Text(subheader)
                    .font(Fonts.poppinsCaption())
            }
        }
    }
}

struct TimelineItem_Previews: PreviewProvider {
    static var previews: some View {
        TimelineItem(header: "Drop Off Confirmation", subheader: "Pending", status: .completed)
    }
}
