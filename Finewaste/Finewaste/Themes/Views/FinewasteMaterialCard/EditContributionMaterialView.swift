//
//  EditContributionMaterialView.swift
//  Finewaste
//
//  Created by Andrean Lay on 09/11/21.
//

import SwiftUI

struct EditContributionMaterialView: View {
    @Environment(\.presentationMode) var presentationMode
    private var materialModel: NewContributionMaterialModel
    
    @State private var quantityTextField = ""
    @State private var selectedImages = [UIImage]()
    
    init(model: NewContributionMaterialModel) {
        self.materialModel = model
        
        if model.quantity != -1 {
            _quantityTextField = State(wrappedValue: String(model.quantity))
        }
        _selectedImages = State(wrappedValue: model.images)
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Specific Requirement")
                        .font(Fonts.poppinsCallout())
                    Text(materialModel.requirements.joined(separator: ", "))
                        .font(Fonts.poppinsSubheadline())
                        .fixedSize(horizontal: false, vertical: true)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Material Quantity")
                        .font(Fonts.poppinsCallout())
                    FinewasteTextField(placeholder: "0 pcs", text: $quantityTextField)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Material Picture")
                        .font(Fonts.poppinsCallout())
                    FinewasteImagePicker(selectedImages: $selectedImages)
                }
                
                Spacer()
            }
            .padding()
            
            .navigationTitle(materialModel.materialName)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Cancel")
                            .foregroundColor(Colors.Turqoise)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        self.materialModel.quantity = Int(quantityTextField) ?? 0
                        self.materialModel.images = selectedImages
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Done")
                            .foregroundColor(Colors.Turqoise)
                    }
                }
            }
        }
    }
}

struct EditContributionMaterialView_Previews: PreviewProvider {
    static let materialModel = NewContributionMaterialModel()
    
    init() {
        EditContributionMaterialView_Previews.materialModel.materialName = "Cotton"
        EditContributionMaterialView_Previews.materialModel.requirements = ["No tear", "Washed"]
        EditContributionMaterialView_Previews.materialModel.quantity = 0
    }
    
    static var previews: some View {
        EditContributionMaterialView(model: materialModel)
    }
}
