//
//  AddImageView.swift
//  Finewaste
//
//  Created by Andrean Lay on 07/11/21.
//

import SwiftUI

struct AddImageView: View {
    var addImageTapped: () -> Void
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Colors.Gray, lineWidth: 1)
                .frame(width: 120, height: 120)
            Image(systemName: "plus.viewfinder")
                .foregroundColor(Colors.Turqoise)
                .font(.system(size: 25).bold())
        }
        .contentShape(Rectangle())
        .onTapGesture(perform: addImageTapped)
    }
}

struct AddImageView_Previews: PreviewProvider {
    static var previews: some View {
        AddImageView(addImageTapped: {})
    }
}
