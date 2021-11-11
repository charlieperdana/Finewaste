//
//  DeliveryView.swift
//  Finewaste
//
//  Created by Kendra Arsena on 03/11/21.
//

import SwiftUI

struct DeliveryView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var deliveryOption: String = ""
    @State var projectAddress: String = ""
    
    @EnvironmentObject var newProject: NewProject
    
    var isFieldFilled: Bool {
        !deliveryOption.isEmpty && !projectAddress.isEmpty
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
                            .frame(width: 80, height: 5)
                        Image(systemName: "2.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 26.0, height: 28.0)
                            .foregroundColor(Colors.RedOverlay)
                        Rectangle()
                            .fill(Colors.RedOverlay)
                            .frame(width: 80, height: 5)
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
                    Spacer().frame(height: 24)
                    Text("Project Address")
                        .font(Fonts.poppinsCallout())
                    Text("Your full address will not be shown on the project")
                        .font(Fonts.poppinsFootnote())
                    FinewasteMapPicker()
                }
                Spacer()
                FinewasteButtonFill(text: "Add Project", size: .fullWidth, isEnabled: isFieldFilled) {
                    print("Add project tapped")
                }
            }
            .font(Fonts.poppinsHeadline())
            .navigationBarTitle("Delivery")
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

struct DeliveryView_Previews: PreviewProvider {
    static var previews: some View {
        DeliveryView()
    }
}
