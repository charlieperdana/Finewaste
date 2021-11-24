//
//  HowWeWorkView.swift
//  Finewaste
//
//  Created by charlie siagian on 17/11/21.
//

import SwiftUI

struct HowWeWorkView: View {
    var body: some View {
        
        ZStack {
            Colors.GrayList.ignoresSafeArea(.all)
            
            VStack(spacing:15){
                Spacer()
                Group {
                    Text("FineWaste helps you connect with fellow upcycling enthusiasts where you will be able to contribute to the environment sustainability collectively.")
                    + Text(" FineWaste is the answer when you want to exchange materials for your project, showcase your current project, or even create a collaboration. Start your upcycling journey with FineWaste!")
                }
                
                Text("You can start either as an upcyclers or as a waste owner. Those roles are very flexible, you can always post a new project to showcase your idea and source the materials. Follow five simple steps below on what you can do with FineWaste.")
                
               
                
                List() {
                    Section(header: Text("WHICH ONE ARE YOU")) {
                        NavigationLink(destination: UpcyclerSettingView()) {
                            Text("I'm an upcycler")
                        }
                        NavigationLink(destination: WasteOwnerSettingView()) {
                            Text("I'm a waste owner")
                        }
                        
                    }
                }
                .onAppear {
    //                UITableView.appearance().backgroundColor = .clear
                    UITableView.appearance().isScrollEnabled = false
                }

                
            }
            .font(Fonts.poppinsBody())
            .padding()
            
            
            
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("How We Work").font(Fonts.poppinsHeadline())
                            .frame(width: 200)
                    }
                }
        }
        }
        
    }
        
}

struct HowWeWorkView_Previews: PreviewProvider {
    static var previews: some View {
        HowWeWorkView()
    }
}
