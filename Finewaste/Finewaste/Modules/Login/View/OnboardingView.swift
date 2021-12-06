//
//  OnboardingView.swift
//  Finewaste
//
//  Created by charlie siagian on 02/11/21.
//

import SwiftUI

struct OnboardingView: View {
    @State private var username: String = ""
    @State private var warningOne: String = "Username must be unique"
    @State private var warningTwo: String = "Username can be between 6-15 characters long"
    @State private var warningThree: String = "Username can only contain alphanumeric characters (letter a-z, numbers 0-9) with exception of underschores."
    
    @State private var isWarningOne = 0
    @State private var isWarningTwo = 0
    @State private var isWarningThree = 0
    
    @State var imageNameOne = "circle"
    @State var imageNameTwo = "circle"
    @State var imageNameThree = "circle"
    
    @ObservedObject var userModel = UserViewModel()
    
    @State var showMainProject = false
    
    @AppStorage("uuid_user") var uuidUser = ""
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var showOnBoardName = false
    
    var body: some View {
        VStack(spacing: 20) {
            
            Image("SetUsernameIllustration")
            Text("What can we call you?")
                .font(Fonts.poppinsTitle())
                .foregroundColor(Colors.Turqoise)
            Text("Set your unique username, you can always change it later")
                .font(Fonts.poppinsFootnote())
                .foregroundColor(Colors.DarkGray)
                .multilineTextAlignment(.center)
                .frame(width: 200)
            VStack(alignment: .leading) {
                TextField("Username", text: $username)
                    .onChange(of: username) {
                        print($0)
                        if $0.count == 0 {
                            isWarningOne = 0
                            isWarningTwo = 0
                            isWarningThree = 0
                            imageNameOne = "circle"
                            imageNameTwo = "circle"
                            imageNameThree = "circle"
                        } else {
                            
                            userModel.checkUsername(username: $0) { result in
                                if result{
                                    self.warningOne = "Someone already use this username"
                                    isWarningOne = 1
                                    imageNameOne = "xmark.circle"
                                } else {
                                    self.warningOne = "No one already use this username"
                                    isWarningOne = 2
                                    imageNameOne = "checkmark.circle"
                                }
                                
                            }
                            
                            if $0.count > 15 || $0.count < 6 {
                                self.isWarningTwo = 1
                                imageNameTwo = "xmark.circle"
                            } else {
                                self.isWarningTwo = 2
                                imageNameTwo = "checkmark.circle"
                            }
                            
                            
                            if ($0.range(of: "^[a-zA-Z0-9_]*$", options:.regularExpression) != nil){
                                self.isWarningThree = 2
                                imageNameThree = "checkmark.circle"
                            } else {
                                self.isWarningThree = 1
                                imageNameThree = "xmark.circle"
                            }
                        }
                        
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .textCase(.lowercase)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .font(Fonts.poppinsSubheadline())
            }
            
            VStack(alignment:.leading, spacing: 3) {
                HStack {
                    Image(systemName: self.imageNameOne)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 10, height: 12)
                        .modifier(WarningImageModifier(isSet: isWarningOne))
                    Text(warningOne)
                        .font(Fonts.poppinsCaption2())
                        .modifier(WarningTextModifier(isSet: isWarningOne))
                    
                }
                HStack(spacing:10) {
                    Image(systemName: self.imageNameTwo)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 10, height: 12)
                        .modifier(WarningImageModifier(isSet: isWarningTwo))
                    Text(warningTwo)
                        .font(Fonts.poppinsCaption2())
                        .modifier(WarningTextModifier(isSet: isWarningTwo))
                    
                }
                HStack(spacing:10) {
                    Image(systemName: self.imageNameThree)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 10, height: 12)
                        .modifier(WarningImageModifier(isSet: isWarningThree))
                    Text(warningThree)
                        .font(Fonts.poppinsCaption2())
                        .modifier(WarningTextModifier(isSet: isWarningThree))
                }
            }
            
            
            Spacer()
            
            FinewasteButtonFill(text: "Next", size: .fullWidth, isEnabled: !username.isEmpty) {
//                let newUser = Users(id: self.uuidUser, name: "", username: self.username, description: "", productService: [""], createdProduct: 0, donatedWaste: 0, location: Location(latitude: 0.0, longitude: 0.0), isBusiness: false)
//
//                userModel.addData(newUser: newUser)
//                self.presentationMode.wrappedValue.dismiss()
                self.showOnBoardName = true
            }
            
            NavigationLink(destination: OnboardingNameView(username: self.username), isActive: $showOnBoardName) {}
        }
        .padding()
    }
}

struct WarningTextModifier: ViewModifier {
    
    var isSet: Int
    
    //    0 = kosong
    //    1 = true
    //    2 = false
    
    func body(content: Content) -> some View {
        Group {
            if self.isSet == 2 {
                content.foregroundColor(Color.green)
            } else if self.isSet == 1 {
                content.foregroundColor(Color.red)
            } else {
                content.foregroundColor(Color.black)
            }
        }
    }
}

struct WarningImageModifier: ViewModifier {
    
    var isSet: Int
    
    func body(content: Content) -> some View {
        Group {
            if self.isSet == 2 {
                content.foregroundColor(Color.green)
            } else if self.isSet == 1 {
                content.foregroundColor(Color.red)
            } else {
                content.foregroundColor(Color.black)
            }
        }
    }
}



struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
