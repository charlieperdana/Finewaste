//
//  OnboardingNameView.swift
//  Finewaste
//
//  Created by charlie siagian on 06/12/21.
//

import SwiftUI
import Firebase

struct OnboardingNameView: View {
    let username : String
    
    @State private var name: String = ""
    
    @ObservedObject var userModel = UserViewModel()
    
    @State var showMainProject = false
    
    @AppStorage("uuid_user") var uuidUser = ""
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var showDashboard = false
    
    var body: some View {
        VStack(spacing: 20) {
            
            Image("SetUsernameIllustration")
            Text("What is your name?")
                .font(Fonts.poppinsTitle())
                .foregroundColor(Colors.Turqoise)
            Text("This to let others know what we should call you on the app")
                .font(Fonts.poppinsFootnote())
                .foregroundColor(Colors.DarkGray)
                .multilineTextAlignment(.center)
                .frame(width: 200)
            VStack(alignment: .leading) {
                TextField("Name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disableAutocorrection(true)
                    .font(Fonts.poppinsSubheadline())
            }
            

            Spacer()
            
            FinewasteButtonFill(text: "Start", size: .fullWidth, isEnabled: !name.isEmpty) {
                let newUser = Users(id: self.uuidUser, name: self.name, username: self.username, description: "", productService: [""], createdProduct: 0, donatedWaste: 0, location: Location(latitude: 0.0, longitude: 0.0), isBusiness: false)
                
//                let newUser = User(id: self.uuidUser, profilePhotoUrl: "", name: self.name, username: self.username, description: "", productServices: [""], createdProducts: 0, donatedWaste: 0, location: GeoPoint(latitude: 0.0, longitude: 0.0), isBusiness: false, productImages: [""], pcsSaved: 0)

                userModel.addData(newUser: newUser)
//                self.presentationMode.wrappedValue.dismiss()
                
                self.showDashboard = true
                
            }
            
            NavigationLink(destination: RootView(), isActive: $showDashboard) {}
            
        }
        .padding()
    }
}

struct OnboardingNameView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingNameView(username: "")
    }
}
