//
//  EditProfileView.swift
//  Finewaste
//
//  Created by charlie siagian on 14/11/21.
//

import SwiftUI
import SDWebImageSwiftUI
import Combine
import CoreLocation
import Firebase
import FirebaseFirestoreSwift

struct EditProfileView: View {
    @ObservedObject var model: ProfileViewModel
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var nameText = ""
    @State var usernameText = ""
    @State var addressText = ""
    @State var descText = ""
    
    var placeholderDesc = "e.g. I am an upcycler specializing in denim upcycling, chat me if you would like to colaborate!"
    
    let textLimit = 500
    
    @State var isUpcycler : Bool = false
    
    @State var defaultCoordinate: CLLocationCoordinate2D = .init(latitude: -6.175784, longitude: 106.827136){
        didSet{
            print("Lokaasinya")
        }
    }
    
    @State private var showMapScreen = false
    
    @State var selectedProfileImages: UIImage? = UIImage()
    
    @State private var isImageFromLocal = false
    
    @State var profilePhotoUrl = ""
    
    var body: some View {

        ScrollViewReader { value in
            ScrollView(.vertical) {
                VStack(spacing:16) {
                    if isImageFromLocal {
                        if let image = self.selectedProfileImages {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                .overlay(Circle().strokeBorder(Color.orange, lineWidth: 2))
                        }
                    }
                    else {
                        WebImage(url: URL(string: (model.user.profilePhotoUrl ?? "")))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .overlay(Circle().strokeBorder(Color.orange, lineWidth: 2))
                    }
                   
                    
                    ProfileImagePicker(selectedImages: $selectedProfileImages, isLoadLocal: $isImageFromLocal)
                    
                    
                    VStack(alignment:.leading, spacing:3) {
                        Text("Name")
                            .font(Fonts.poppinsCallout())
                        
                        FinewasteTextField(placeholder: "e.g. Jonathan", text: $nameText)
                    }
                    
                    VStack(alignment:.leading, spacing:3) {
                        Text("Username")
                            .font(Fonts.poppinsCallout())
                        FinewasteTextField(placeholder: "e.g. jonathan_123", text: $usernameText)
                    }
                    
                    VStack(alignment:.leading, spacing:3) {
                        Text("Project Address")
                            .font(Fonts.poppinsCallout())
                        Text("Your full address will not be shown on your profile")
                            .font(Fonts.poppinsCaption())
//                        ZStack {
//                            RoundedRectangle(cornerRadius: 10)
//                                .stroke(Colors.Gray)
//                            TextField("Type your adreess here...", text: $addressText)
//                                .font(Fonts.poppinsSubheadline())
//                                .padding([.leading, .trailing], 16)
//                                .padding([.top, .bottom], 12)
//
//                            HStack {
//                                Spacer()
//                                Button {
//                                    self.showMapScreen = true
//
//                                } label: {
//                                    Image(systemName: "map")
//                                        .foregroundColor(Colors.Turqoise)
//                                        .frame(alignment: .trailing)
//                                }
//                            .padding()
//                            }
//
//
//                            NavigationLink(destination: MapPinPointView(currentCoordinate: $defaultCoordinate), isActive: $showMapScreen) {
//                                EmptyView()
//                            }
//
//                        }
//                        .frame(height: 58)
                        
                        FinewasteMapPicker(isReadOnly: false, currentAddress: $addressText, currentCoordinate: $defaultCoordinate, isShowingMap: false)
                       
                    }
                    
                    VStack(alignment:.leading, spacing:3) {
                        Text("Description")
                            .font(Fonts.poppinsCallout())
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Colors.Gray)
                            
                            
                            TextEditor(text: $descText)
                                .font(Fonts.poppinsSubheadline())
                            //                                .foregroundColor(self.descText == self.placeholderDesc ? .gray :.primary)
                            //                                .onTapGesture {
                            //                                    if self.descText == self.placeholderDesc {
                            //                                        self.descText = ""
                            //                                    }
                            //                                }
                                .padding([.leading, .trailing], 16)
                                .padding([.top, .bottom], 12)
                                .onReceive(Just(descText)) { _ in limitDescText(textLimit) }
                            
                            
                        }
                        .frame(height: 98)
                        
                        Text("\(descText.count)/500")
                            .font(Fonts.poppinsFootnote())
                            .foregroundColor(Colors.Turqoise)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                        
                    }
                    
                    VStack() {
                        Toggle(isOn: $isUpcycler){
                            Text("Are you an Upcycler")
                                .font(Fonts.poppinsCallout())
                        }.onChange(of: isUpcycler) { isUp in
                            if isUp {
                                value.scrollTo(8)
                            }
                        }
                        
                    }
                    
                    if isUpcycler {
                        UpcyclerActiveView()
                            .id(8)
                    }
                    
                }
                .onReceive(self.model.$user) { user in
                    self.nameText = user.name ?? ""
                    self.usernameText = user.username ?? ""
                    self.descText = user.description ?? ""
                    if let location = user.location{
                        self.defaultCoordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
                        
                        
                        model.getLocationName(latitude: location.latitude, longitude: location.longitude, completion: { value in
                            self.addressText = value
                        })
                    }
                    
                    if let isUpcycler = user.isBusiness {
                        self.isUpcycler = isUpcycler
                    }
                   
                }
                
                
                
                
                
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading:
                                    HStack {
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Cancel").font(Fonts.poppinsBody()).foregroundColor(Colors.Turqoise)
                }
            }
            )
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        let id = model.user.id
                        self.profilePhotoUrl = model.user.profilePhotoUrl ?? ""
                        let name = self.nameText
                        let username = self.usernameText
                        let desc = self.descText
                        let createdProducts = model.user.createdProducts
                        let donatedWaste = model.user.donatedWaste
                        let location = GeoPoint(latitude: self.defaultCoordinate.latitude, longitude: self.defaultCoordinate.longitude)
                        let isBusiness = isUpcycler
                        let prodService = [UpcyclerActiveView().productService]
//                        let prodService = [""]
                        
                        if let profileImage = self.selectedProfileImages {
                            self.model.uploadProfileImages(image: profileImage) { value in
                                self.profilePhotoUrl = value
                                print("isi poto:\(self.profilePhotoUrl)")
                            }
                            
                        } else {
                            print("Image gak ada")
                        }
                        
                       
                        print("isi poto 2:\(self.profilePhotoUrl)")
                        
                        
                        self.model.updateProfile(data: User(id: id, profilePhotoUrl: profilePhotoUrl, name: name, username: username, description: desc, productServices: prodService, createdProducts: createdProducts, donatedWaste: donatedWaste, location: location, isBusiness: isBusiness))
                        
                        self.presentationMode.wrappedValue.dismiss()
                        
                        print("Keluar : \(defaultCoordinate)")
                        
                    } label: {
                        Text("Done").font(Fonts.poppinsBody()).foregroundColor(Colors.Gray)
                    }
                    
                    
                }
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Edit Profile").font(Fonts.poppinsHeadline())
                    }
                }
            }
        }
    }
    
    
    func limitDescText(_ upper: Int) {
        if descText.count > upper {
            descText = String(descText.prefix(upper))
        }
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(model: ProfileViewModel(userId: "8xayV4ivOsOSqUrNiD0kOHM7jih1"))
//        EditProfileView()
    }
}
