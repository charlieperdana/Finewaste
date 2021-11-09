//
//  MainProjectView.swift
//  Finewaste
//
//  Created by charlie siagian on 04/11/21.
//

import SwiftUI
import Firebase

struct MainProjectView: View {
    
    @ObservedObject var model = ProjectViewModel()
    
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
    
    
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                VStack {
                    
                    SearchBarView(searchText: $searchText, isSearching: $isSearching)
                    
//                    List(model.listProject) { item in
//
//                    }
                    
//                    ForEach(model.listProject){project in
//                        Text(project.projectName!)
//                    }
                    
//                    ForEach((1...10), id: \.self) {
//                        Text("\($0)…")
//                    }

//                    ProjectGridView(project: $project)
                    ProjectGridView(listProject: $model.listProject)
                    
//                    Divider()
//
//                    VStack(spacing:5){
//                        TextField("Username", text: $username)
//                            .textFieldStyle(RoundedBorderTextFieldStyle())
//
//                        TextField("Fullname", text: $fullname)
//                            .textFieldStyle(RoundedBorderTextFieldStyle())
//
//                        TextField("UUID", text: $uid)
//                            .textFieldStyle(RoundedBorderTextFieldStyle())
//
//                    }
//
//                    .padding()
                    
                    
                    
                }
                .navigationBarTitle(Text("Projects").font(Fonts.poppinsTitle()))
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Button {
                            
                        }label: {
                            Image(systemName: "plus")
                                .foregroundColor(Colors.Turqoise)
                        }
                        Button {
                            DispatchQueue.global(qos: .background).async {
                                try? Auth.auth().signOut()
                            }
                            
                            withAnimation(.easeInOut) {
                                logStatus = false
                            }
                        }label: {
                            Text("Log Out")
                                .foregroundColor(Colors.Turqoise)
                        }
                    }
                }
            }
        }
        .navigationBarHidden(true)
    }
    
    init() {
        model.getProjectData()

        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "Poppins-SemiBold", size: 28)!]
    }
}

struct MainProjectView_Previews: PreviewProvider {
    static var previews: some View {
        MainProjectView()
    }
}
