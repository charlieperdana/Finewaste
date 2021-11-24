//
//  PrivacyPolicyView.swift
//  Finewaste
//
//  Created by charlie siagian on 17/11/21.
//

import SwiftUI

struct PrivacyPolicyView: View {
    var body: some View {
        ScrollView {
            VStack(alignment:.leading, spacing: 15) {
                Text("Privacy Policy").fontWeight(.medium)
                
                Text("We The X built the FineWaste app as a Free app. This SERVICE is provided by We The X at no cost and is intended for use as is.")
                
                Text("This page is used to inform visitors regarding my policies with the collection, use, and disclosure of Personal Information if anyone decided to use my Service.")
                
                Group {
                    Text("If you choose to use my Service, then you agree to the collection and use of information in relation to this policy.")
                    + Text(" The Personal Information that I collect is used for providing and improving the Service. I will not use or share your information with anyone except as described in this Privacy Policy.")
                }
                
                Text("The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which is accessible at FineWaste unless otherwise defined in this Privacy Policy.")
                
                Text("Information Collection and Use").fontWeight(.medium)
                
                Text("For a better experience, while using our Service, I may require you to provide us with certain personally identifiable information, including but not limited to Location. The information that I request will be retained on your device and is not collected by me in any way.")
                
                Text("The app does use third party services that may collect information used to identify you.")
            }
            .padding()
            .font(Fonts.poppinsBody())
            .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        VStack {
                            Text("Privacy Policy").font(Fonts.poppinsHeadline())
                                .frame(width: 100)
                        }
                    }
            }
        }
    }
}

struct PrivacyPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPolicyView()
    }
}
