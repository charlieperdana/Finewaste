//
//  ProjectDetailView.swift
//  Finewaste
//
//  Created by Andrean Lay on 02/11/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

struct ProjectDetailView: View {
    @State var opacity = 0.0

    private var halfWidth: CGFloat {
        UIScreen.main.bounds.width * 0.5
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        ProjectImageCarouselView()
                            .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fit)
                            .background(GeometryReader {
                                Color.clear.preference(
                                    key: ViewOffsetKey.self,
                                    value: -$0.frame(in: .named("scroll")).origin.y
                                )
                            })
                        
                        ProjectOwnerView()
                        Divider()
                        ProjectDescriptionView()
                    }
                    .onPreferenceChange(ViewOffsetKey.self) { value in
                        self.opacity = value / self.halfWidth
                    }
                }
                .coordinateSpace(name: "scroll")
                
                VStack {
                    ProjectNavigationBar(navBarOpacity: min(opacity, 1.0))
                    Spacer()
                }
                
                VStack {
                    Spacer()
                    FinewasteButton(text: "Contribute", size: .fullWidth, isEnabled: true) {
                        
                    }
                }
                .padding([.leading, .trailing])
            }
            .edgesIgnoringSafeArea(.top)
        }
        .navigationBarHidden(true)
    }
}

struct ProjectDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectDetailView()
    }
}
