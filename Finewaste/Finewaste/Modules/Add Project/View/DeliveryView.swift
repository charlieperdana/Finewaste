//
//  DeliveryView.swift
//  Finewaste
//
//  Created by Kendra Arsena on 03/11/21.
//

import SwiftUI
import CoreLocation
import FirebaseFirestore

struct DeliveryView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var deliveryOption: String = ""
    
    @EnvironmentObject var newProject: NewProjectModel
    @StateObject private var viewModel = DeliveryViewModel()
    
    @Binding var isPresentingAddProjectSheet: Bool
    
    var isFieldFilled: Bool {
        !deliveryOption.isEmpty && viewModel.isLocationSelected
    }
    
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
                            .foregroundColor(Colors.RedOverlay)
                        Rectangle()
                            .fill(Colors.RedOverlay)
                            .frame(width: 80, height: 2)
                            .opacity(0.3)
                        Image(systemName: "3.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 26.0, height: 28.0)
                            .foregroundColor(Colors.Red)
                    }
                    Text("About")
                        .foregroundColor(Colors.RedOverlay)
                        .font(Fonts.poppinsFootnote())
                        .fontWeight(.semibold)
                        .offset(x: -106, y: 30)
                    Text("Material")
                        .foregroundColor(Colors.RedOverlay)
                        .font(Fonts.poppinsFootnote())
                        .fontWeight(.semibold)
                        .offset(y: 30)
                    Text("Delivery")
                        .foregroundColor(Colors.Red)
                        .font(Fonts.poppinsFootnote())
                        .fontWeight(.semibold)
                        .offset(x: 106, y: 30)
                }
                Spacer().frame(height: 0)
                VStack(alignment: .leading) {
                    Text("Delivery Option")
                        .font(Fonts.poppinsCallout())
                    Spacer().frame(height: 16)
                    FinewastePicker(placeholder: "Choose delivery option", selectedData: $deliveryOption, dataToChoose: ["Drop off", "Pick up", "Drop off or pick up"])
                    if deliveryOption != "" {
                        Spacer().frame(height: 24)
                        Text("Project Address")
                            .font(Fonts.poppinsCallout())
                        Text("Your full address will not be shown on the project")
                            .font(Fonts.poppinsFootnote())
                        FinewasteMapPicker(isReadOnly: false, currentAddress: $viewModel.projectModel.deliveryAddress, currentCoordinate: $viewModel.pickUpCoordinate, isShowingMap: true)
                    }
                }
                Spacer()
                FinewasteButtonFill(text: "Add Project", size: .fullWidth, isEnabled: isFieldFilled) {
                    if deliveryOption == "Drop off or pick up" {
                        newProject.deliveryType.append(contentsOf: ["Drop off", "Pick up"])
                    } else {
                        newProject.deliveryType.append(deliveryOption)
                    }
                    newProject.location = GeoPoint(latitude: self.viewModel.pickUpCoordinate.latitude, longitude: self.viewModel.pickUpCoordinate.longitude)
                    viewModel.postProject(newProject: newProject)
                    isPresentingAddProjectSheet = false
                }
            }
            .onAppear(perform: {
                viewModel.projectModel = newProject
            })
            .font(Fonts.poppinsHeadline())
            .navigationBarTitle("Delivery")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading:
                                    Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 17, weight: .semibold, design: .default))
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Colors.Turqoise)
            })
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
        }.navigationBarHidden(true)
    }
}

struct DeliveryView_Previews: PreviewProvider {
    static var previews: some View {
        DeliveryView(isPresentingAddProjectSheet: .constant(false))
    }
}
