//
//  TermOfUseView.swift
//  Finewaste
//
//  Created by charlie siagian on 17/11/21.
//

import SwiftUI

struct TermOfUseView: View {
    var body: some View {
        ScrollView {
            VStack(alignment:.leading, spacing: 15) {
                Text("The FineWaste app is a copyrighted work belonging to We The X (Company). Certain features of the app may be subject to additional guidelines, terms, or rules, which will be posted on the app in connection with such features.")
                
                Text("All such additional terms, guidelines, and rules are incorporated by reference into these Terms.")
                
                Group {
                    Text("These Terms of Use described the legally binding terms and conditions that oversee your use of the App. BY LOGGING INTO THE APP, YOU ARE BEING COMPLIANT THAT THESE TERMS and you represent that you have the authority and capacity to enter into these Terms. ")
                    + Text("YOU SHOULD BE AT LEAST 18 YEARS OF AGE TO ACCESS THE APP. IF YOU DISAGREE WITH ALL OF THE PROVISION OF THESE TERMS, DO NOT LOG INTO AND/OR USE THE APP.")
                }
                
                Text("Access to the App")
                
                Group {
                    Text("Subject to these Terms.").fontWeight(.medium) +
                    Text(" For a better experience, while using our Service, I may require you to provide us with certain personally identifiable information, including but not limited to Location.")
                    + Text(" The information that I request will be retained on your device and is not collected by me in any way.")
                }
                
            }
            .padding()
            .font(Fonts.poppinsBody())
            .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        VStack {
                            Text("Terms of Use").font(Fonts.poppinsHeadline())
                        }
                    }
            }
        }
    }
}

struct TermOfUseView_Previews: PreviewProvider {
    static var previews: some View {
        TermOfUseView()
    }
}
