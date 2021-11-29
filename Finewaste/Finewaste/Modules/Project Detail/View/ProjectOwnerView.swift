//
//  ProjectOwnerView.swift
//  Finewaste
//
//  Created by Andrean Lay on 03/11/21.
//

import SwiftUI
import SDWebImageSwiftUI
import FirebaseAuth

struct ProjectOwnerView: View {
    private var posterId: String
    private var posterName: String
    private var posterUsername: String
    private var profilePhotoUrl: String
    
    init(project: Project) {
        self.posterId = project.poster ?? "---"
        self.posterName = project.posterName ?? "---"
        self.posterUsername = project.posterUsername ?? "---"
        self.profilePhotoUrl = project.posterPhotoUrl ?? "---"
    }
    
    @State var showOthersProfile = false
    
    var body: some View {
        HStack {
            Group {
                FinewasteSmallCirclePicture(fromUrl: profilePhotoUrl)
                Text(posterUsername)
                    .font(Fonts.poppinsCallout())
            }.onTapGesture {
                self.showOthersProfile = true
            }
            Spacer()
            ChatButton(receiverId: posterId, receiverName: posterName, receiverPhotoUrl: profilePhotoUrl)
            
            NavigationLink(destination: OthersProfileView(userId: self.posterId), isActive: $showOthersProfile) {}
        }
        .padding(.all, 16)
    }
}

struct ProjectOwnerView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectOwnerView(project: Project())
    }
}
