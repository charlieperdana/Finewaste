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
    
    var body: some View {
        HStack {
            FinewasteSmallCirclePicture(fromUrl: profilePhotoUrl)
            Text(posterUsername)
                .font(Fonts.poppinsCallout())
            Spacer()
            ChatButton(receiverId: posterId, receiverName: posterName)
        }
        .padding(.all, 16)
    }
}

struct ProjectOwnerView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectOwnerView(project: Project())
    }
}
