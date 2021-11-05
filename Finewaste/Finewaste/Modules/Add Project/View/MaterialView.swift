//
//  MaterialView.swift
//  Finewaste
//
//  Created by Kendra Arsena on 03/11/21.
//

import SwiftUI

struct MaterialView: View {
    var body: some View {
        VStack {
            NavigationView {
                Text("")
                    .font(Fonts.poppinsHeadline())
                    .navigationBarTitle("Add Material")
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
                        .foregroundColor(Colors.Red)
                    Rectangle()
                        .fill(Colors.Gray)
                        .frame(width: 80, height: 5)
                    Image(systemName: "3.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 26.0, height: 28.0)
                        .foregroundColor(Colors.Gray)
                }
                Text("About")
                    .foregroundColor(Colors.RedOverlay)
                    .font(Fonts.poppinsFootnote())
                    .bold()
                    .offset(x: -106, y: 30)
                Text("Material")
                    .foregroundColor(Colors.Red)
                    .font(Fonts.poppinsFootnote())
                    .bold()
                    .offset(y: 30)
                Text("Delivery")
                    .foregroundColor(Colors.Gray)
                    .font(Fonts.poppinsFootnote())
                    .bold()
                    .offset(x: 106, y: 30)
            }
            Spacer().frame(height: 32)
            Button(action: {
                print("button add material tapped")
            }) {
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Colors.Gray)
                        .frame(width: 358, height: 44)
                        .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                    Text("Add Material")
                        .foregroundColor(Colors.Turqoise)
                        .font(Fonts.poppinsHeadline())
                }
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
                    Text("Next")
                        .foregroundColor(Colors.White)
                        .font(Fonts.poppinsHeadline())
                }
            }
        }
    }
}

struct MaterialView_Previews: PreviewProvider {
    static var previews: some View {
        MaterialView()
    }
}
