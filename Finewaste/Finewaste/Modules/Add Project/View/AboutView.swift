//
//  AboutView.swift
//  Finewaste
//
//  Created by Kendra Arsena W on 04/11/21.
//

import SwiftUI

struct AboutView: View {
    @State var projectName: String = ""
    @State var projectDescription: String = ""
    @State var selectedDate = Date()
    @State var image = UIImage()
    
    @State var showSheet = false
    
    var body: some View {
        VStack {
            NavigationView {
                Text("")
                    .font(Fonts.poppinsHeadline())
                    .navigationBarTitle("Project Detail")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarItems(leading:
                                            Button(action: {
                        print("close tapped")
                    }) {
                        Image(systemName: "xmark")
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
                        .foregroundColor(Colors.Red)
                    Rectangle()
                        .fill(Colors.Gray)
                        .frame(width: 80, height: 5)
                    Image(systemName: "2.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 26.0, height: 28.0)
                        .foregroundColor(Colors.Gray)
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
                    .foregroundColor(Colors.Red)
                    .font(Fonts.poppinsFootnote())
                    .bold()
                    .offset(x: -106, y: 30)
                Text("Material")
                    .foregroundColor(Colors.Gray)
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
            VStack(alignment: .leading) {
                Text("Project Name")
                    .font(Fonts.poppinsCallout())
                TextField("e.g. Denim totebag", text: $projectName)
                    .font(Fonts.poppinsSubheadline())
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                HStack {
                    Spacer()
                    Text("\(projectName.count)/30")
                        .font(Fonts.poppinsFootnote())
                        .foregroundColor(Colors.Turqoise)
                }
                Text("What do you want to make?")
                    .font(Fonts.poppinsCallout())
                TextField("Describe product you want to make", text: $projectDescription)
                    .font(Fonts.poppinsSubheadline())
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                HStack {
                    Spacer()
                    Text("\(projectDescription.count)/500")
                        .font(Fonts.poppinsFootnote())
                        .foregroundColor(Colors.Turqoise)
                }
                HStack {
                    Text("Project Close Date")
                        .font(Fonts.poppinsCallout())
                    DatePicker("", selection: $selectedDate, in: Date()..., displayedComponents: .date)
                }
                Text("Product Image Reference")
                    .font(Fonts.poppinsCallout())
                HStack {
                    Button(action: {
                        self.showSheet = true
                    }) {
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Colors.Gray)
                                .frame(width: 100, height: 100)
                            Image(systemName: "plus.viewfinder")
                                .frame(width: 30, height: 30, alignment: .center)
                                .foregroundColor(Colors.Turqoise)
                        }
                    }
                    .sheet(isPresented: $showSheet) {
                        ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
                    }
                    Image(uiImage: self.image)
                        .resizable()
                        .cornerRadius(10)
                        .frame(width: 100, height: 100)
                    Image(uiImage: self.image)
                        .resizable()
                        .cornerRadius(10)
                        .frame(width: 100, height: 100)
                }
                HStack {
                    Image(uiImage: self.image)
                        .resizable()
                        .cornerRadius(10)
                        .frame(width: 100, height: 100)
                    Image(uiImage: self.image)
                        .resizable()
                        .cornerRadius(10)
                        .frame(width: 100, height: 100)
                    Image(uiImage: self.image)
                        .resizable()
                        .cornerRadius(10)
                        .frame(width: 100, height: 100)
                }
            }.padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
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

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
