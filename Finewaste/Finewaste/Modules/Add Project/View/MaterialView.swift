//
//  MaterialView.swift
//  Finewaste
//
//  Created by Kendra Arsena on 03/11/21.
//

import SwiftUI
import FirebaseFirestore

struct MaterialView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var showNextPage = false
    @State var showSheet = false
    @State var showAlert = false
    
    @EnvironmentObject var newProject: NewProjectModel
    
    @State var selectedMaterial = NewMaterialModel(name: "", target: 0, limit: false, requirements: [])
    
    @State var showDeliveryPage = false
    @State var editMaterial = false
    
    @Binding var isPresentingAddProjectSheet: Bool
    
    var body: some View {
        NavigationView {
            VStack(spacing: 32) {
                ZStack {
                    HStack(spacing: 0) {
                        Image(systemName: "1.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 26.0, height: 28.0)
                            .foregroundColor(Colors.RedOverlay)
                        Rectangle()
                            .fill(Colors.RedOverlay)
                            .frame(width: 80, height: 2)
                            .opacity(0.3)
                        Image(systemName: "2.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 26.0, height: 28.0)
                            .foregroundColor(Colors.Red)
                        Rectangle()
                            .fill(Colors.Gray)
                            .frame(width: 80, height: 2)
                            .opacity(0.3)
                        Image(systemName: "3.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 26.0, height: 28.0)
                            .foregroundColor(Colors.Gray)
                    }
                    Text("About")
                        .foregroundColor(Colors.RedOverlay)
                        .font(Fonts.poppinsFootnote())
                        .fontWeight(.semibold)
                        .offset(x: -106, y: 30)
                    Text("Material")
                        .foregroundColor(Colors.Red)
                        .font(Fonts.poppinsFootnote())
                        .fontWeight(.semibold)
                        .offset(y: 30)
                    Text("Delivery")
                        .foregroundColor(Colors.Gray)
                        .font(Fonts.poppinsFootnote())
                        .fontWeight(.semibold)
                        .offset(x: 106, y: 30)
                }
                Spacer().frame(height: 0)
                if newProject.newMaterial.count > 0 {
                    ForEach(newProject.newMaterial, id: \.materialName) { data in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(data.materialName)
                                    .font(Fonts.poppinsBody())
                                Text((data.materialPrerequisite.joined(separator: ", ")))
                                    .font(Fonts.poppinsCaption())
                            }.padding()
                            Spacer()
                            Button(action: {
                                selectedMaterial = data
                                editMaterial = true
                                self.showSheet = true
                            }) {
                                Text("Edit")
                                    .foregroundColor(Colors.Turqoise)
                                    .font(Fonts.poppinsHeadline())
                            }.padding()
                        }.overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke(Colors.Turqoise, lineWidth: 1))
                    }
                }
                FinewasteRoundedOutlineButton(text: "Add New Material", size: .fullWidth) {
                    editMaterial = false
                    self.showSheet = true
                }
                .sheet(isPresented: $showSheet) {
                    AddMaterialView(selectedMaterial: selectedMaterial, editMaterial: editMaterial)
                }
                Spacer()
                FinewasteButtonFill(text: "Next", size: .fullWidth, isEnabled: newProject.newMaterial.count > 0) {
                    self.showDeliveryPage = true
                }
                NavigationLink(destination: DeliveryView(isPresentingAddProjectSheet: $isPresentingAddProjectSheet).environmentObject(newProject), isActive: $showDeliveryPage) {}
            }.font(Fonts.poppinsHeadline())
                .navigationBarTitle("Add Material")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(leading:
                                        Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(Colors.Turqoise)
                })
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
        }.navigationBarHidden(true)
    }
}

struct MaterialView_Previews: PreviewProvider {
    static var previews: some View {
        MaterialView(isPresentingAddProjectSheet: .constant(false))
    }
}
