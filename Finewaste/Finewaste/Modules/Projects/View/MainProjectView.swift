//
//  MainProjectView.swift
//  Finewaste
//
//  Created by charlie siagian on 04/11/21.
//

import SwiftUI
import Firebase

struct MainProjectView: View {
    @StateObject var model = ProjectViewModel()
    
    @AppStorage("log_status") var logStatus = false
    
    @StateObject var loginData = LoginViewModel()
    
    
    @State private var username = ""
    @State private var fullname = ""
    @State private var uid = ""
    
    @AppStorage("uuid_user") var uuidUser = ""
    @AppStorage("username_user") var usernameUser = ""
    
    @State var searchText = ""
    @State var isSearching = false
    
    @State var project = Project()
    
    @State var isPresentingLoginSheet = false
    
    var body: some View {
        ScrollView {
            VStack {
                
                SearchBarView(searchText: $searchText, isSearching: $isSearching)
                
                ProjectGridView(model: model,searchText: $searchText)
                
                
            }
            .navigationBarTitle(Text("Projects").font(Fonts.poppinsTitle()))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        if !AuthenticationHelper.shared.isLoggedIn {
                            self.isPresentingLoginSheet.toggle()
                        }
                    }label: {
                        Image(systemName: "plus")
                            .foregroundColor(Colors.Turqoise)
                    }
                }
            }
            .sheet(isPresented: $isPresentingLoginSheet) {
                LoginView(loginTrigger: .addProject)
            }
        }
    }
    
    init() {
//        model.getProjectData()

        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "Poppins-SemiBold", size: 28)!]
    }
}

struct MainProjectView_Previews: PreviewProvider {
    static var previews: some View {
        MainProjectView()
    }
}
