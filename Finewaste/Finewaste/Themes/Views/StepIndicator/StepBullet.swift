//
//  StepBullet.swift
//  Finewaste
//
//  Created by Andrean Lay on 09/11/21.
//

import SwiftUI

struct StepBullet: View {
    var step: Int
    var text: String
    var isActivated: Bool
    
    private var imageName: String {
        return "\(step).circle.fill"
    }
    
    init(forStep step: Int, text: String, isActivated: Bool) {
        self.step = step
        self.text = text
        self.isActivated = isActivated
    }
    
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: imageName)
                .font(.title2)
            Text(text)
                .font(Fonts.poppinsFootnoteBold())
        }
    }
}

struct StepBullet_Previews: PreviewProvider {
    static var previews: some View {
        StepBullet(forStep: 1, text: "", isActivated: true)
    }
}
