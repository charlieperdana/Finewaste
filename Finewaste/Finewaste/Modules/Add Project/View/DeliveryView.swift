//
//  DeliveryView.swift
//  Finewaste
//
//  Created by Kendra Arsena on 03/11/21.
//

import SwiftUI

struct DeliveryView: View {
    @State var deliveryOption: String = ""
    @State var projectAddress: String = ""
    
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
            Spacer().frame(height: 24)
            ZStack{
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
                    .bold()
                    .offset(x: -106, y: 30)
                Text("Material")
                    .foregroundColor(Colors.RedOverlay)
                    .font(Fonts.poppinsFootnote())
                    .bold()
                    .offset(y: 30)
                Text("Delivery")
                    .foregroundColor(Colors.Red)
                    .font(Fonts.poppinsFootnote())
                    .bold()
                    .offset(x: 106, y: 30)
            }
            Spacer().frame(height: 32)
            VStack(alignment: .leading) {
                Text("Delivery Option")
                    .font(Fonts.poppinsCallout())
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0))
                HStack {
                    TextField("Choose delivery option", text: $deliveryOption)
                    .font(Fonts.poppinsSubheadline())
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0))
                    Image(systemName: "chevron.right")
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 8)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16))
                        .foregroundColor(Colors.Gray)
                }
                Divider()
                    .frame(height: 1, alignment: .center)
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                    .padding(.horizontal, 30)
                    .background(Colors.Gray)
                Text("Project Address")
                    .font(Fonts.poppinsCallout())
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0))
                Text("Your full address will not be shown on the project")
                    .font(Fonts.poppinsFootnote())
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0))
                TextField("Type your address here..", text: $projectAddress)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .font(Fonts.poppinsSubheadline())
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                RoundedRectangle(cornerRadius: 10)
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                    .frame(height: 200)
            }
            Spacer()
            Button(action: {
                print("button next tapped")
            }) {
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Colors.Gray)
                        .frame(width: 358, height: 44)
                        .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                    Text("Add Project")
                        .foregroundColor(Colors.White)
                        .font(Fonts.poppinsHeadline())
                }
            }
        }
    }
}

struct DeliveryView_Previews: PreviewProvider {
    static var previews: some View {
        DeliveryView()
    }
}
