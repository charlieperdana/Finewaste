//
//  RejectContributionView.swift
//  Finewaste
//
//  Created by Andrean Lay on 15/11/21.
//

import SwiftUI

enum RejectionSide {
    case projectOwner
    case wasteOwner
}

struct RejectContributionView: View {
    @Environment(\.presentationMode) var presentationMode
    private let title: String
    private let prompt: String
    private let reasons: [String]

    @State private var currentSelectionIndex = -1
    @State private var otherReasonsText = ""
    
    @StateObject private var viewModel: RejectContributionViewModel
    
    init(for side: RejectionSide, contributionId: String) {
        self._viewModel = StateObject(wrappedValue: RejectContributionViewModel(contributionId: contributionId, rejectionSide: side))
        
        if side == .projectOwner {
            self.reasons = ContributionRejection.ProjectOwner.reasons
            self.prompt = ContributionRejection.ProjectOwner.prompt
            self.title = ContributionRejection.ProjectOwner.title
        } else {
            self.reasons = ContributionRejection.WasteOwner.reasons
            self.prompt = ContributionRejection.WasteOwner.prompt
            self.title = ContributionRejection.WasteOwner.title
        }
    }

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 32) {
                Text(prompt)
                    .font(Fonts.poppinsTitle())
                
                
                VStack(spacing: 12) {
                    VStack(spacing: 8) {
                        ForEach(reasons.indices, id: \.self) { index in
                            RejectReasonOption(
                                reason: reasons[index],
                                isActive: currentSelectionIndex == index
                            )
                            .onTapGesture {
                                withAnimation {
                                    self.currentSelectionIndex = index
                                }
                            }
                        }
                    }
                    
                    if currentSelectionIndex == reasons.firstIndex(of: "Other reason") {
                        FinewasteLimitTextField(placeholder: "Write down your reason", text: $otherReasonsText, maximumCharacter: 100)
                    }
                }
                
                Spacer()
                
                FinewasteButtonFill(
                    text: "Submit",
                    size: .fullWidth,
                    isEnabled: currentSelectionIndex != -1) {
                        if currentSelectionIndex != reasons.firstIndex(of: "Other reason") {
                            viewModel.rejectContribution(reason: reasons[currentSelectionIndex])
                        } else {
                            viewModel.rejectContribution(reason: otherReasonsText)
                        }
                        
                        self.presentationMode.wrappedValue.dismiss()
                }
            }
            .padding()
            
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 17).weight(.medium))
                            .foregroundColor(Colors.Turqoise)
                    }
                }
            }
        }
    }
}

struct RejectContributionView_Previews: PreviewProvider {
    static var previews: some View {
        RejectContributionView(for: .projectOwner, contributionId: "")
    }
}
