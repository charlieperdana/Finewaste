//
//  AddMaterialView.swift
//  Finewaste
//
//  Created by Kendra Arsena W on 04/11/21.
//

import SwiftUI

struct AddMaterialView: View {
    @State var materialNeeded: String = ""
    @State var materialRequirement: String = ""
    @State var materialQuantity: String = ""
    
    var body: some View {
        VStack {
            NavigationView {
                Text("")
                    .font(Fonts.poppinsHeadline())
                    .navigationBarTitle("Delivery")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarItems(leading:
                                            Button(action: {
                        print("close tapped")
                    }) {
                        Image(systemName: "chevron.left")
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(Colors.Turqoise)
                    })
            }.frame(maxHeight: 42)
            VStack(alignment: .leading) {
                Text("What kind of material do you need?")
                    .font(Fonts.poppinsCallout())
                TextField("e.g. Denim", text: $materialNeeded)
                    .font(Fonts.poppinsSubheadline())
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Text("Material Requirement")
                    .font(Fonts.poppinsCallout())
                TextField("e.g. No big stains, good condition", text: $materialRequirement)
                    .font(Fonts.poppinsSubheadline())
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Text("Material target quantity")
                    .font(Fonts.poppinsCallout())
                TextField("e.g. Denim", text: $materialQuantity)
                    .font(Fonts.poppinsSubheadline())
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }.padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
            Spacer()
        }
    }
}

struct AddMaterialView_Previews: PreviewProvider {
    static var previews: some View {
        AddMaterialView()
    }
}
