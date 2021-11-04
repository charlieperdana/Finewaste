//
//  ProjectContentView.swift
//  Finewaste
//
//  Created by Andrean Lay on 02/11/21.
//

import SwiftUI

private enum ProjectContentType: String, CaseIterable {
    case about = "About"
    case update = "Update"
}

struct ProjectContentView: View {
    @State private var selectedContentView = ProjectContentType.about.rawValue
    private var contentTypes = ProjectContentType.allCases.map {
        $0.rawValue
    }

    var body: some View {
        Group {
            Picker("", selection: $selectedContentView) {
                ForEach(contentTypes, id: \.self) { name in
                    Text(name)
                }
            }
            .pickerStyle(.segmented)
            
            switch ProjectContentType(rawValue: selectedContentView) {
            case .about:
                ProjectAboutView()
            case .update:
                ProjectUpdateView()
            default:
                EmptyView()
            }
        }
    }
}

struct ProjectContentView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectContentView()
    }
}
