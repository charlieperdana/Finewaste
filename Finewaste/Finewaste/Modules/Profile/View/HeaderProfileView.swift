//
//  HeaderProfileView.swift
//  Finewaste
//
//  Created by charlie siagian on 13/11/21.
//

import SDWebImageSwiftUI

import SwiftUI

struct HeaderProfileView: View {
    
    @ObservedObject var model: ProfileViewModel
    
    @State var showMyProject = false
    @State var showMyContrProject = false
    
    
    var body: some View {
        VStack {
            HStack {
                WebImage(url: URL(string: (model.user.profilePhotoUrl ?? "")))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .overlay(Circle().strokeBorder(Color.orange, lineWidth: 2))
                
                VStack(spacing:12){
                    HStack {
                        Spacer()
                        Button(action: {
                           
                        }) {
                            VStack {
                                Text("4300")
                                    .font(Fonts.poppinsTitle())
                                Text("pcs saved")
                                    .font(Fonts.poppinsFootnote())
                            }.foregroundColor(Colors.Black)
                        }
                        Spacer()
                        Button(action: {
                            self.showMyProject = true
                        }) {
                            VStack {
                                Text("\(model.myProjectNumber)")
                                    .font(Fonts.poppinsTitle())
                                Text("projects")
                                    .font(Fonts.poppinsFootnote())
                            }.foregroundColor(Colors.Black)
                        }
                        Spacer()
                        Button(action: {
                            self.showMyContrProject = true
                        }) {
                            VStack {
                                Text("\(model.myContributionNumber)")
                                    .font(Fonts.poppinsTitle())
                                Text("contributed")
                                    .font(Fonts.poppinsFootnote())
                            }.foregroundColor(Colors.Black)
                        }
                        
                    }
                    
                    
                }
                NavigationLink(destination: MyProjectView(), isActive: $showMyProject) {}
                NavigationLink(destination: MyContributeProjectView(), isActive: $showMyContrProject) {}
                    
            }
            
        
        
        
        }
    }
}

struct HeaderProfileView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderProfileView(model: ProfileViewModel(userId: "8xayV4ivOsOSqUrNiD0kOHM7jih1"))
    }
}
