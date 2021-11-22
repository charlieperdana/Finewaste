//
//  MyProjectsView.swift
//  Finewaste
//
//  Created by Kendra Arsena W on 11/11/21.
//

import SwiftUI

struct MyProjectsView: View {
    
    @StateObject var viewModel = MyProjectsViewModel()
    
    var body: some View {
        VStack {
            Spacer().frame(height: 16)
            if viewModel.projects.isEmpty {
                Spacer()
                Text("No contribution yet")
                    .font(Fonts.poppinsCallout())
                    .foregroundColor(Colors.Gray)
                Spacer()
            } else {
                ForEach(viewModel.contributions, id: \.id) { contribution in
                    FinewasteContributionStatusCard(contribution: contribution)
                }
            }
            
        }
    }
}

struct MyProjectsView_Previews: PreviewProvider {
    static var previews: some View {
        MyProjectsView(viewModel: MyProjectsViewModel())
    }
}

// Cek User sekarang, punya project apa -> dari each project, cek contributions nya
