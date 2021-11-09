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
    @State var isReceivingMore: Bool = false
    
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var newProject: NewProject
    
    var isFieldFilled: Bool {
        !materialNeeded.isEmpty && !materialRequirement.isEmpty && !materialQuantity.isEmpty
    }
    
    var body: some View {
        NavigationView {
            VStack {
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
                    TextField("e.g. 25 pcs", text: $materialQuantity)
                        .font(Fonts.poppinsSubheadline())
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                    HStack {
                        Text("Receive more than target")
                            .font(Fonts.poppinsFootnote())
                            .foregroundColor(Colors.Turqoise)
                        Spacer()
                        Toggle("", isOn: $isReceivingMore)
                    }   
                }
                Spacer()
            }
            .font(Fonts.poppinsHeadline())
            .navigationBarTitle("Delivery")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Cancel")
                    .font(Fonts.poppinsBody())
                    .foregroundColor(Colors.Turqoise)
            }), trailing: Button(action: {
                let requirements = materialRequirement.components(separatedBy: ",")
                let target = Int(self.materialQuantity) ?? 0
                newProject.newMaterial.append(NewMaterial(name: materialNeeded, target: target, limit: isReceivingMore, requirements: requirements))
                presentationMode.wrappedValue.dismiss()
            }, label: {
                if isFieldFilled {
                    Text("Add")
                        .font(Fonts.poppinsHeadline())
                        .foregroundColor(Colors.Turqoise)
                } else {
                    Text("Add")
                        .font(Fonts.poppinsHeadline())
                        .foregroundColor(Colors.Gray)
                }
            }).disabled(!isFieldFilled)
            )
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
        }
    }
}

struct AddMaterialView_Previews: PreviewProvider {
    static var previews: some View {
        AddMaterialView()
    }
}
