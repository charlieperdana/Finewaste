//
//  ProjectDetailView.swift
//  Finewaste
//
//  Created by Andrean Lay on 02/11/21.
//

import SwiftUI
import SDWebImageSwiftUI

private enum ProjectContentType: String, CaseIterable {
    case about = "About"
    case update = "Update"
}

struct ProjectDetailView: View {
    @State var opacity = 0.0

    @State private var selectedContentView = ProjectContentType.about.rawValue
    private var contentTypes = ProjectContentType.allCases.map {
        $0.rawValue
    }
    
    @StateObject private var viewModel: ProjectDetailViewModel
    
    @State private var isPresentingAddContribution = false
    @State private var isPresentingLoginSheet = false
    
    init(projectId: String) {
        _viewModel = StateObject(wrappedValue: ProjectDetailViewModel(projectId: projectId))
    }
    
    var body: some View {
        if let project = viewModel.project {
            ZStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        ProjectImageCarouselView(images: project.images ?? [])
                            .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fit)
                            .trackScrollPosition(coordinateSpace: .named("scrollPosition"))
                        
                        ProjectOwnerView()
                        Divider()
                        
                        Text(project.projectName ?? "---")
                            .font(Fonts.poppinsTitle2())
                            .padding([.leading, .top])
                        
                        VStack(alignment: .leading, spacing: 16) {
                            ProjectStatusView(project: project)
                            
                            Group {
                                Picker("", selection: $selectedContentView) {
                                    ForEach(contentTypes, id: \.self) { name in
                                        Text(name)
                                    }
                                }
                                .pickerStyle(.segmented)
                                
                                switch ProjectContentType(rawValue: selectedContentView) {
                                    case .about:
                                        ProjectAboutView(viewModel: viewModel)
                                    case .update:
                                        ProjectUpdateView(projectId: viewModel.projectId)
                                    default:
                                        EmptyView()
                                }
                            }
                            
                            // Add empty space to accomodate floating contribute button
                            // The distance from last text to button is 32
                            // The button size is 44
                            // Thus by adding them, we need 32 + 44 = 76px to get desired result
                            Spacer()
                                .frame(height: 76)
                        }
                        .padding([.leading, .trailing])
                    }
                }
                .coordinateSpace(name: "scrollPosition")
                .getScrollPosition($opacity)
                
                VStack {
                    ProjectNavigationBar(navBarOpacity: opacity)
                    Spacer()
                }
                
                VStack {
                    Spacer()
                    ZStack(alignment:. top) {
                        Color.white
                            .frame(height: 78)
                        FinewasteButtonFill(text: "Contribute", size: .fullWidth, isEnabled: true) {
                            print(AuthenticationHelper.shared.userId ?? "----")
                            if !AuthenticationHelper.shared.isLoggedIn {
                                self.isPresentingLoginSheet.toggle()
                                return
                            }
                            
                            isPresentingAddContribution = true
                        }
                        .padding([.leading, .trailing])
                    }
                }
                .edgesIgnoringSafeArea(.top)
                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
            }
            
            .fullScreenCover(isPresented: $isPresentingAddContribution) {
                AddContributionView(projectId: viewModel.projectId)
            }
            .sheet(isPresented: $isPresentingLoginSheet) {
                LoginView(loginTrigger: .addContribution)
            }
        } else {
            Text("Loading..")
                .navigationBarHidden(true)
        }
    }
}

struct ProjectDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectDetailView(projectId: "")
    }
}
