//
//  HistoryView.swift
//  Finewaste
//
//  Created by Kendra Arsena W on 19/11/21.
//

import SwiftUI

private enum ContributionHistoryContentType: String, CaseIterable {
    case contributions = "My Contributions"
    case projects = "My Projects"
}

struct HistoryView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var selectedContentView = ContributionHistoryContentType.contributions.rawValue
    private var contentTypes = ContributionHistoryContentType.allCases.map {
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
                    
                    ScrollView {
                        switch ContributionHistoryContentType(rawValue: selectedContentView) {
                        case .contributions:
                            HistoryContributionView()
                        case .projects:
                            HistoryProjectView()
                        default:
                            EmptyView()
                        }
                    }
                }
                Spacer()
            }
            .navigationBarTitle("Contribution History")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Colors.Turqoise)
            })
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
        }
        .navigationBarHidden(true)
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
