//
//  EditProfileView.swift
//  Finewaste
//
//  Created by charlie siagian on 14/11/21.
//

import SwiftUI
import SDWebImageSwiftUI
import Combine

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
    
    var body: some View {

        ScrollViewReader { value in
            ScrollView(.vertical) {
                VStack(spacing:16) {
                    WebImage(url: URL(string: (model.user.profilePhotoUrl ?? "")))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .overlay(Circle().strokeBorder(Color.orange, lineWidth: 2))
                    
                    FinewasteRoundedOutlineButton(text: "Change Profile Image", size: .fullWidth) {
                        
                    }
                    
                    
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
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Colors.Gray)
                            TextField("Type your adreess here...", text: $addressText)
                                .font(Fonts.poppinsSubheadline())
                                .padding([.leading, .trailing], 16)
                                .padding([.top, .bottom], 12)
                            
                            Button {
                                
                            } label: {
                                Image(systemName: "map")
                                    .foregroundColor(Colors.Turqoise)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                            }
                            .padding()
                            
                        }
                        .frame(height: 58)
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
                    self.addressText = model.locationName
                    self.descText = user.description ?? ""
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
                        let profilePhotoUrl = model.user.profilePhotoUrl
                        let name = self.nameText
                        let username = self.usernameText
                        let desc = self.descText
                        let prodService = [""]
                        let createdProducts = model.user.createdProducts
                        let donatedWaste = model.user.donatedWaste
                        let location = model.user.location
                        let isBusiness = model.user.isBusiness
                        
                        self.model.updateProfile(data: User(id: id, profilePhotoUrl: profilePhotoUrl, name: name, username: username, description: desc, productServices: prodService, createdProducts: createdProducts, donatedWaste: donatedWaste, location: location, isBusiness: isBusiness))
                        
                        self.presentationMode.wrappedValue.dismiss()
                        
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
