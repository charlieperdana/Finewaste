//
//  AboutView.swift
//  Finewaste
//
//  Created by Kendra Arsena W on 04/11/21.
//

import SwiftUI
import FirebaseFirestore

class NewProjectModel: ObservableObject {
    var projectName: String = ""
    var projectDesc: String = ""
    var deadline: Timestamp = Timestamp(seconds: 0, nanoseconds: 0)
    var images: [UIImage] = []
    var deliveryType: [String] = []
    @Published var deliveryAddress: String = ""
    var location: GeoPoint = GeoPoint(latitude: 0, longitude: 0)
    @Published var newMaterial = [NewMaterialModel]()
}

class NewMaterialModel: ObservableObject {
    init(name: String, target: Int, limit: Bool, requirements: [String]) {
        materialName = name
        materialTarget = target
        allowOverlimit = limit
        materialPrerequisite = requirements
    }
    @Published var materialName: String = ""
    @Published var materialTarget: Int = 0
    var allowOverlimit: Bool = false
    @Published var materialPrerequisite: [String] = []
}

struct AboutView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var projectName: String = ""
    @State var projectDescription: String = ""
    @State var selectedDate = Date()
    @State var images = [UIImage]()
    
    @State var showSheet = false
    @State var showNextPage = false
    @State var showAlert = false
    
    @Binding var isPresentingAddProjectSheet: Bool
    
    @StateObject var newProject = NewProjectModel()
    
    var minimumCloseDate = Calendar.current.date(byAdding: .day, value: 7, to: Date()) ?? Date()
    
    var isFieldFilled:Bool {
        !projectName.isEmpty && !projectDescription.isEmpty && !images.isEmpty
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 32) {
//                Spacer().frame(height: 24)
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
                        .fontWeight(.semibold)
                        .offset(x: -106, y: 30)
                    Text("Material")
                        .foregroundColor(Colors.Gray)
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
                VStack(alignment: .leading) {
                    Text("Project Name")
                        .font(Fonts.poppinsCallout())
                    FinewasteTextField(placeholder: "e.g. Denim totebag", text: $projectName)
                    HStack {
                        Spacer()
                        Text("\(projectName.count)/30")
                            .font(Fonts.poppinsFootnote())
                            .foregroundColor(Colors.Turqoise)
                    }
                    Text("What do you want to make?")
                        .font(Fonts.poppinsCallout())
                    FinewasteTextField(placeholder: "Describe product you want to make", text: $projectDescription)
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
                    FinewasteImagePicker(selectedImages: $images)
                }
                Spacer()
                FinewasteButtonFill(text: "Next", size: .fullWidth, isEnabled: isFieldFilled) {
                    newProject.projectName = projectName
                    newProject.projectDesc = projectDescription
                    newProject.deadline = Timestamp(seconds: Int64(selectedDate.timeIntervalSince1970), nanoseconds: 0)
                    newProject.images = images
                    self.showNextPage = true
                }
                NavigationLink(destination: MaterialView(isPresentingAddProjectSheet: $isPresentingAddProjectSheet).environmentObject(newProject), isActive: $showNextPage) {}
            }
            .navigationBarTitle("Project Detail")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading:
                                    Button(action: {
                self.showAlert = true
            }) {
                Image(systemName: "xmark")
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Colors.Turqoise)
            })
            .alert(isPresented: $showAlert, content: {
                Alert(title: Text("Unsaved Change"),
                      message: Text("Are you sure you want to discard the changes? Your changes will be lost."),
                      primaryButton: .default(Text("Cancel")
                                                .foregroundColor(Colors.Turqoise)),
                      secondaryButton: .destructive(Text("Discard"), action: {
                    self.presentationMode.wrappedValue.dismiss()
                })
                )
            })
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView(isPresentingAddProjectSheet: .constant(false))
    }
}
