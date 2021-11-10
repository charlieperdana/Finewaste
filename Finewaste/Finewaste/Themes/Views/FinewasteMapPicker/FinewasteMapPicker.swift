//
//  FinewasteMapPicker.swift
//  Finewaste
//
//  Created by Andrean Lay on 10/11/21.
//

import SwiftUI

struct FinewasteMapPicker: View {
    var body: some View {
        VStack(spacing: 16) {
            LocationAddressField()
            MapView(isVisualOnly: true)
                .frame(height: 200)
                .cornerRadius(10)
        }
    }
}

struct FinewasteMapPicker_Previews: PreviewProvider {
    static var previews: some View {
        FinewasteMapPicker()
    }
}
