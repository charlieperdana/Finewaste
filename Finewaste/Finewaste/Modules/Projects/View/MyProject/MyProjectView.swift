//
//  MyProjectView.swift
//  Finewaste
//
//  Created by charlie siagian on 11/11/21.
//

import SwiftUI

struct MyProjectView: View {
    @StateObject var model = MyProjectViewModel(user: "8xayV4ivOsOSqUrNiD0kOHM7jih1")
    
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
        //        NavigationView {
        
        
        ScrollView {
            VStack {
                
                SearchBarView(searchText: $searchText, isSearching: $isSearching)
                
                MyProjectGridView(model: model,searchText: $searchText)
                
                
            }
            //                .navigationBarTitle(Text("My Projects"), displayMode: .inline)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("My Projects").font(Fonts.poppinsHeadline())
                    }
                }
            }
        }
        //        }
        //        .navigationBarHidden(true)
        //        .navigationBarItems(leading: btnBack)
    }
    
    init() {
        //        UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: "Poppins-SemiBold", size: 17)!]
    }
}

struct MyProjectView_Previews: PreviewProvider {
    static var previews: some View {
        MyProjectView()
    }
}
