//
//  ContributionStatusView.swift
//  Finewaste
//
//  Created by Kendra Arsena W on 11/11/21.
//

import SwiftUI

private enum ContributionStatusContentType: String, CaseIterable {
    case contributions = "My Contributions"
    case projects = "My Projects"
}

struct ContributionStatusView: View {
    @State private var selectedContentView = ContributionStatusContentType.contributions.rawValue
    private var contentTypes = ContributionStatusContentType.allCases.map {
        $0.rawValue
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer().frame(height: 16)
                Group {
                    Picker("", selection: $selectedContentView) {
                        ForEach(contentTypes, id: \.self) { name in
                            Text(name)
                                .font(Fonts.poppinsFootnote())
                                .fontWeight(.semibold)
                        }
                    }
                    .pickerStyle(.segmented)
                    switch ContributionStatusContentType(rawValue: selectedContentView) {
                    case .contributions:
                        MyContributionsView()
                    case .projects:
                        MyProjectsView()
                    default:
                        EmptyView()
                    }
                }
                Spacer()
            }
            .navigationBarTitle("Contribution Status", displayMode: .large)
            .navigationBarItems(trailing: Button(action: {
                print("History tapped")
            }, label: {
                Text("History")
                    .font(Fonts.poppinsHeadline())
                    .foregroundColor(Colors.Turqoise)
            }))
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
        }
    }
}

struct ContributionStatusView_Previews: PreviewProvider {
    static var previews: some View {
        ContributionStatusView()
    }
}