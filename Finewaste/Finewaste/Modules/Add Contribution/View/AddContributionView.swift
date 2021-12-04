//
//  AddContributionView.swift
//  Finewaste
//
//  Created by Andrean Lay on 09/11/21.
//

import SwiftUI

struct AddContributionView: View {
    private let stepPlaceholder = ["Material", "Delivery"]
    private let stepNavigationTitle = ["Select Material", "Set Delivery"]
    private let bottomButtonText = ["Next", "Submit Contribution Request"]
    
    @Environment(\.presentationMode) var presentationMode
    @State private var currentStep = 1
    private var maxStep = 2
    
    @StateObject var viewModel: AddContributionViewModel
    
    init(project: Project) {
        self._viewModel = StateObject(wrappedValue: AddContributionViewModel(project: project))
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    PaginationView(currentStep: $currentStep, maxStep: maxStep, stepPlaceholder: stepPlaceholder)
                    switch currentStep {
                    case 1:
                        SelectMaterialView(model: viewModel.contributionModel)
                            .transition(.asymmetric(insertion: .opacity, removal: .offset(x: -300, y: 0)))
                    case 2:
                        SetDeliveryView(model: viewModel.contributionModel)
                            .transition(.asymmetric(insertion: .opacity, removal: .offset(x: -300, y: 0)))
                    default:
                        EmptyView()
                    }
                    
                    Spacer()
                    FinewasteButtonFill(text: bottomButtonText[currentStep - 1], size: .fullWidth, isEnabled: true) {
                        if currentStep < maxStep {
                            withAnimation {
                                currentStep += 1
                            }
                        } else {
                            viewModel.postContribution()
                        }
                    }
                }
                .padding()
                
                if viewModel.postingContribution {
                    PostUploadIndicator(currentProgress: Double(viewModel.uploadedImages) / Double(viewModel.totalImages)) {
                        viewModel.cancelPostContribution()
                    }
                    .onChange(of: viewModel.uploadedImages) { val in
                        if val == viewModel.totalImages {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
            }
            
            .navigationTitle(stepNavigationTitle[currentStep - 1])
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    if currentStep != 1 {
                        Button(action: {
                            withAnimation {
                                currentStep -= 1
                            }
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(Colors.Turqoise)
                        }
                    } else {
                        Button {
                            self.presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "xmark")
                                .foregroundColor(Colors.Turqoise)
                        }
                    }
                }
            }
        }
    }
}

struct AddContributionView_Previews: PreviewProvider {
    static var previews: some View {
        AddContributionView(project: Project())
    }
}
