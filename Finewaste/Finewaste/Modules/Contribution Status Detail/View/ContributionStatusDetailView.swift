//
//  ContributionStatusDetailView.swift
//  Finewaste
//
//  Created by Andrean Lay on 11/11/21.
//

import SwiftUI
import FirebaseFirestore

struct ContributionStatusDetailView: View {
    @StateObject private var viewModel: ContributionStatusDetailViewModel
    
    init(contributionId: String) {
        self._viewModel = StateObject(wrappedValue: ContributionStatusDetailViewModel(contributionId: contributionId))
    }
    
    var body: some View {
        if let contribution = viewModel.contribution {
            ZStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 32) {
                        HStack {
                            VStack(alignment: .leading, spacing: 8) {
                                Text(viewModel.isProjectOwner ? "Contributor" : "Project Owner")
                                    .font(Fonts.poppinsCallout())
                                Text("DonateforCycle.id")
                                    .font(Fonts.poppinsSubheadline())
                            }
                            Spacer()
                            FinewasteButtonFill(text: "Chat", size: .small, isEnabled: true) {
                                
                            }
                        }
                        ContributionTimeline(contribution: contribution)
                        Divider()
                        ContributionDetail(contribution: contribution, materials: viewModel.materials)
                        
                        Spacer()
                        
                        
                    }
                    .padding()
                    
                    Spacer()
                        .frame(height: 76)
                }
                
                switch viewModel.currentStatus {
                case .waitingConfirmation:
                    InitialActionsView(viewModel: viewModel)
                case .confirmed:
                    SetDeliveryActionsView(viewModel: viewModel)
                case .deliverySet:
                    DeliveryConfirmationActionsView(viewModel: viewModel)
                case .deliveryConfirmed:
                    DeliveryConfirmedActionsView(viewModel: viewModel)
                default:
                    EmptyView()
                }
            }
            .navigationTitle(contribution.projectName ?? "---")
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationBackButton()
                }
            }
        } else {
            Text("Fetching contribution data..")
        }
    }
}


private struct InitialActionsView: View {
    @ObservedObject var viewModel: ContributionStatusDetailViewModel
    
    @State private var isShowingCancelContribution = false
    
    var body: some View {
        VStack {
            Spacer()
            ZStack(alignment:. top) {
                Color.white
                    .frame(height: viewModel.isProjectOwner ? 128 : 78)
                
                VStack(spacing: 8) {
                    if true {
                        FinewasteTapHoldButton(text: "Hold to Reject", style: .outline, onHoldDoneAction: {
                            self.isShowingCancelContribution.toggle()
                        })
                        FinewasteTapHoldButton(text: "Hold to Confirm", style: .fill, onHoldDoneAction: {
                            viewModel.confirmContribution()
                        })
                    } else {
                        FinewasteTapHoldButton(text: "Hold to Cancel", style: .fill, onHoldDoneAction: {
                            self.isShowingCancelContribution.toggle()
                        })
                    }
                }
                .fullScreenCover(isPresented: $isShowingCancelContribution) {
                    RejectContributionView(for: viewModel.isProjectOwner ? .projectOwner : .wasteOwner, contributionId: viewModel.contributionId)
                }
                .padding(.horizontal)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

private struct SetDeliveryActionsView: View {
    @ObservedObject var viewModel: ContributionStatusDetailViewModel
    
    @State private var isShowingDatePicker = false
    @State private var selectedDate: Timestamp = .init(seconds: 0, nanoseconds: 0)
    
    var body: some View {
        VStack {
            Spacer()
            ZStack(alignment:. top) {
                if !isShowingDatePicker {
                    Color.white
                        .frame(height: 78)
                    
                    Group {
                        if viewModel.isProjectOwner && viewModel.deliveryType == "Pick up" {
                            FinewasteButtonFill(text: "Set Pick Up Schedule", size: .fullWidth, isEnabled: true) {
                                self.isShowingDatePicker = true
                            }
                        } else if !viewModel.isProjectOwner && viewModel.deliveryType == "Drop off" {
                            FinewasteButtonFill(text: "Set Drop Off Schedule", size: .fullWidth, isEnabled: true) {
                                withAnimation {
                                    self.isShowingDatePicker = true
                                }
                            }
                        } else {
                            EmptyView()
                        }
                    }
                    .padding(.horizontal)
                } else {
                    WheelDatePicker(
                        datesList: viewModel.getAvailableDeliveryDates(),
                        selectedDate: $selectedDate,
                        cancelOnTap: {
                            self.isShowingDatePicker = false
                        },
                        doneOnTap: {
                            viewModel.setDeliveryDate(chosenDate: selectedDate)
                            self.isShowingDatePicker = false
                        })
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

private struct DeliveryConfirmationActionsView: View {
    @ObservedObject var viewModel: ContributionStatusDetailViewModel
    
    @State private var isShowingDatePicker = false
    @State private var selectedDate: Timestamp = .init(seconds: 0, nanoseconds: 0)
    
    var body: some View {
        VStack {
            Spacer()
            ZStack(alignment:. top) {
                if !isShowingDatePicker {
                    Color.white
                        .frame(height: 128)
                    
                    VStack(spacing: 8) {
                        if viewModel.isProjectOwner && viewModel.deliveryType == "Pick up" {
                            FinewasteButtonOutline(
                                text: "Edit Pick Up Schedule",
                                size: .fullWidth,
                                isEnabled: true) {
                                    self.isShowingDatePicker = true
                                }
                            FinewasteButtonFill(text: "Confirm Pick Up Schedule", size: .fullWidth, isEnabled: true) {
                                viewModel.confirmDeliveryDate(chosenDate: selectedDate)
                            }
                        } else if !viewModel.isProjectOwner && viewModel.deliveryType == "Drop off" {
                            FinewasteButtonOutline(
                                text: "Edit Drop Off Schedule",
                                size: .fullWidth,
                                isEnabled: true) {
                                    self.isShowingDatePicker = true
                                }
                            FinewasteButtonFill(text: "Confirm Drop Off Schedule", size: .fullWidth, isEnabled: true) {
                                viewModel.confirmDeliveryDate(chosenDate: selectedDate)
                            }
                        } else {
                            EmptyView()
                        }
                    }
                    .padding(.horizontal)
                } else {
                    WheelDatePicker(
                        datesList: viewModel.getAvailableDeliveryDates(),
                        selectedDate: $selectedDate,
                        cancelOnTap: {
                            self.isShowingDatePicker = false
                        },
                        doneOnTap: {
                            viewModel.setDeliveryDate(chosenDate: selectedDate)
                            self.isShowingDatePicker = false
                        })
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            if let date = viewModel.contribution?.deliveryDate {
                selectedDate = date
            }
        }
    }
}

private struct DeliveryConfirmedActionsView: View {
    @ObservedObject var viewModel: ContributionStatusDetailViewModel
    @State private var isShowingCancelReasonView = false
    
    var body: some View {
        VStack {
            Spacer()
            ZStack(alignment:. top) {
                Color.white
                    .frame(height: 78)
                
                FinewasteTapHoldButton(text: "Hold to Confirm", style: .fill, onHoldDoneAction: {
                    viewModel.confirmDeliveryFinished()
                })
                .padding(.horizontal)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}
