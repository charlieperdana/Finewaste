//
//  PostUploadIndicator.swift
//  Finewaste
//
//  Created by Andrean Lay on 08/11/21.
//

import SwiftUI

struct PostUploadIndicator: View {
    var currentProgress: Double
    var onCancelTapped: () -> Void
    
    var body: some View {
        ZStack(alignment: .center) {
            Color.black
                .opacity(0.4)
            ZStack {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Posting...")
                        .font(Fonts.poppinsHeadline())
                        .frame(height: 16)
                    ProgressView(value: currentProgress, total: 1)
                        .scaleEffect(x: 1, y: 2, anchor: .center)
                        .accentColor(Colors.Red)
                        .font(Fonts.poppinsCallout())
                        .animation(.linear)
                    FinewasteButtonOutline(text: "Cancel", size: .fullWidth, isEnabled: true, onButtonTap: onCancelTapped)
                }
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .frame(width: 358, height: 178)
                )
            }
            .padding(32)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct PostUploadIndicator_Previews: PreviewProvider {
    static var previews: some View {
        PostUploadIndicator(currentProgress: 0.2) {}
    }
}
