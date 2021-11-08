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
    
    @State var project: Project
    
    init(project: Project) {
        self._project = State(wrappedValue: project)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer().frame(height: 24)
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
                Spacer().frame(height: 40)
                HStack {
                    VStack(alignment: .leading) {
                        Text("Denim")
                            .font(Fonts.poppinsBody())
                        Text("No bleach stains, good condition")
                            .font(Fonts.poppinsCaption())
                    }.padding()
                    Spacer()
                    Button(action: {
                        print("Edit tapped")
                    }) {
                        Text("Edit")
                            .foregroundColor(Colors.Turqoise)
                            .font(Fonts.poppinsHeadline())
                    }.padding()
                }.overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(Colors.Turqoise, lineWidth: 1))
                FinewasteRoundedOutlineButton(text: "Add New Material", size: .fullWidth) {
                    self.showSheet = true
                }
                .sheet(isPresented: $showSheet) {
                    AddMaterialView()
                }
                Spacer()
                FinewasteButtonFill(text: "Next", size: .fullWidth, isEnabled: true) {
                    print("Next tapped")
                }
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
        MaterialView(project: Project.init())
    }
}
