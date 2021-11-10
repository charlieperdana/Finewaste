//
//  LocationAddressField.swift
//  Finewaste
//
//  Created by Andrean Lay on 10/11/21.
//

import SwiftUI

struct LocationAddressField: View {
    @State private var text = ""
    
    var body: some View {
        HStack {
            TextField("Type your address here...", text: $text)
            Spacer()
            NavigationLink(destination: MapPinPointView()) {
                Image(systemName: "map")
                    .foregroundColor(Colors.Turqoise)
                    .font(.system(size: 22))
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Colors.Gray)
        )
    }
}

struct LocationAddressField_Previews: PreviewProvider {
    static var previews: some View {
        LocationAddressField()
    }
}
