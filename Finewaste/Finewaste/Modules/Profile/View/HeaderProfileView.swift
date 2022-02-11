//
//  HeaderProfileView.swift
//  Finewaste
//
//  Created by charlie siagian on 13/11/21.
//

import SwiftUI
import Kingfisher

struct HeaderProfileView: View {
    
    @ObservedObject var model: ProfileViewModel
    
    @State var showMyProject = false
    @State var showMyContrProject = false
    @State var showOthersProfile = false
    
    @Binding var isGuest : Bool
    
    
    var body: some View {
        VStack {
            HStack {
                if(isGuest){
                    Image("profile")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
//                        .overlay(Circle().strokeBorder(Color.orange, lineWidth: 2))
                } else {
                    KFImage(URL(string: (model.user.profilePhotoUrl ?? "")))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .overlay(Circle().strokeBorder(Colors.PlaceholderGray, lineWidth: 2))
                }
                
                
                VStack(spacing:12){
                    HStack {
                        Spacer()
                        Button(action: {
                            self.showOthersProfile = true
                        }) {
                            VStack {
                                Text(String(model.user.pcsSaved ?? 0))
                                    .font(Fonts.poppinsTitle())
                                Text("pcs saved")
                                    .font(Fonts.poppinsFootnote())
                            }
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
                            }
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
                            }
                        }
                        
                    }
                    
                    
                }
                NavigationLink(destination: MyProjectView(), isActive: $showMyProject) {}
                NavigationLink(destination: MyContributeProjectView(), isActive: $showMyContrProject) {}
//                NavigationLink(destination: OnboardingView(), isActive: $showOthersProfile) {}
                    
            }
            
        
        
        
        }
    }
}

struct HeaderProfileView_Previews: PreviewProvider {
    @State static var isGuest = true
    static var previews: some View {
        HeaderProfileView(model: ProfileViewModel(userId: "8xayV4ivOsOSqUrNiD0kOHM7jih1"), isGuest: $isGuest)
    }
}
