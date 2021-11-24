//
//  MyContributeProjectView.swift
//  Finewaste
//
//  Created by charlie siagian on 12/11/21.
//

import SwiftUI

struct MyContributeProjectView: View {
//    @StateObject var model = MyContributeProjectViewModel(user: "8xayV4ivOsOSqUrNiD0kOHM7jih1")
    
    @StateObject var model = MyContributeProjectViewModel(user: AuthenticationHelper.shared.userId ?? "")

    @State var searchText = ""
    @State var isSearching = false
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var btnBack : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
    }) {
        HStack {
            Image(systemName: "chevron.backward")
                .foregroundColor(Colors.Turqoise)
                .font(.system(size: 23).weight(.medium))
                .aspectRatio(contentMode: .fit)
        }
    }
    }
    
    var body: some View {

            ScrollView {
                VStack {
                    
                    SearchBarView(searchText: $searchText, isSearching: $isSearching)
                    
                    if(model.listProject.count <= 0 )
                    {
                        Spacer()
                        Text("No contribution yet")
                            .font(Fonts.poppinsCallout())
                            .foregroundColor(Colors.Gray)
//                        Spacer()
                    } else {
                        MyContributeProjectGridView(model: model,searchText: $searchText)
                    }
                    
                    
                    
                    
                }

                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        VStack {
                            Text("Contributed").font(Fonts.poppinsHeadline())
                        }
                    }
                }
            }
//        }
//        .navigationBarHidden(true)
//        .navigationBarItems(leading: btnBack)
    }
    
//    init() {
//        UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: "Poppins-SemiBold", size: 17)!]
//    }
}

struct MyContributrProjectView_Previews: PreviewProvider {
    static var previews: some View {
        MyContributeProjectView()
    }
}
