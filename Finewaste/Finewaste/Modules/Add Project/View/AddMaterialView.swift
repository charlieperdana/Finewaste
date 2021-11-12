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
    
    init(selectedMaterial: NewMaterial, editMaterial: Bool) {
        self.selectedMaterial = selectedMaterial
        self.editMaterial = editMaterial
        if editMaterial {
            self._materialNeeded = State(wrappedValue: selectedMaterial.materialName)
            self._materialRequirement = State(wrappedValue: selectedMaterial.materialPrerequisite.joined(separator: ","))
            self._materialQuantity = State(wrappedValue: String(selectedMaterial.materialTarget))
            self._isReceivingMore = State(wrappedValue: selectedMaterial.allowOverlimit)
        }
    }
    
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var newProject: NewProject
    var selectedMaterial: NewMaterial
    var editMaterial: Bool = false
    
    var isFieldFilled: Bool {
        !materialNeeded.isEmpty && !materialRequirement.isEmpty && !materialQuantity.isEmpty
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer().frame(height: 16)
                VStack(alignment: .leading) {
                    Text("What kind of material do you need?")
                        .font(Fonts.poppinsCallout())
                    FinewasteTextField(placeholder: "e.g. Denim", text: $materialNeeded)
                    Text("Material Requirement")
                        .font(Fonts.poppinsCallout())
                    FinewasteTextField(placeholder: "e.g. No big stains, good condition", text: $materialRequirement)
                    Text("Material target quantity")
                        .font(Fonts.poppinsCallout())
                    FinewasteTextField(placeholder: "e.g. 25 pcs", text: $materialQuantity)
                        .keyboardType(.numberPad)
                    Spacer().frame(height: 16)
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
                if editMaterial {
                    selectedMaterial.materialName = materialNeeded
                    selectedMaterial.materialTarget = target
                    selectedMaterial.allowOverlimit = isReceivingMore
                    selectedMaterial.materialPrerequisite = requirements
                } else {
                    newProject.newMaterial.append(NewMaterial(name: materialNeeded, target: target, limit: isReceivingMore, requirements: requirements))
                }
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
        AddMaterialView(selectedMaterial: NewMaterial(name: "", target: 0, limit: false, requirements: []), editMaterial: false)
    }
}
