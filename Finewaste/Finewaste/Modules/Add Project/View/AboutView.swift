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
    @State var showNextPage = false
    
    @State var project = Project()
    
    var minimumCloseDate = Calendar.current.date(byAdding: .day, value: 7, to: Date()) ?? Date()
    
    var isFieldFilled:Bool {
        !projectName.isEmpty && !projectDescription.isEmpty
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
                Spacer().frame(height: 40)
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
                        DatePicker("", selection: $selectedDate, in: minimumCloseDate..., displayedComponents: .date)
                    }
                    Text("Product Image Reference")
                        .font(Fonts.poppinsCallout())
                    HStack {
                        Button(action: {
                            self.showSheet = true
                        }) {
                            ZStack {
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
                    }
                }
                Spacer()
                FinewasteButton(text: "Next", size: .fullWidth, isEnabled: isFieldFilled) {
                    project.projectName = projectName
                    project.description = projectDescription
                    project.deadline = selectedDate
                    self.showNextPage = true
                }
                NavigationLink(destination: MaterialView(), isActive: $showNextPage) {}
            }
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
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
