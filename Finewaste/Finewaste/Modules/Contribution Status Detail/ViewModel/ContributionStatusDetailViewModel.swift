//
//  ContributionStatusDetailViewModel.swift
//  Finewaste
//
//  Created by Andrean Lay on 11/11/21.
//

import Combine
import FirebaseFirestore

class ContributionStatusDetailViewModel: ObservableObject {
    private var contributionRepository = ContributionRepository()
    private var contributionMaterialRepository = ContributionMaterialRepository()

    @Published var contributionId: String
    @Published var contribution: Contribution? {
        didSet {
            if let status = contribution?.status {
                self.currentStatus = ContributionStatus(from: status)
            }
            if let ownerId = contribution?.projectOwnerId {
                self.isProjectOwner = AuthenticationHelper.shared.userId == ownerId
            }
            if let deliveryType = contribution?.deliveryType {
                self.deliveryType = deliveryType
            }
        }
    }
    @Published var materials = [ContributionMaterial]()
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var currentStatus: ContributionStatus = .unknown
    @Published var isProjectOwner: Bool = false
    @Published var deliveryType: String = ""
    
    init(contributionId: String) {
        self.contributionId = contributionId
        
        contributionRepository.$contribution
            .compactMap { $0 }
            .assign(to: \.contribution, on: self)
            .store(in: &cancellables)
        
        contributionMaterialRepository.$contributionMaterials
            .compactMap { $0 }
            .assign(to: \.materials, on: self)
            .store(in: &cancellables)

        contributionRepository.getContribution(id: contributionId)
        contributionMaterialRepository.getContributionMaterials(contributionIds: [contributionId])
    }
    
    func getAvailableDeliveryDates() -> [Timestamp] {
        guard let confirmedDate = self.contribution?.confirmedDate else {
            return []
        }
        
        var availableDays = [Timestamp]()
        let secondsInADay = 86_400
        for day in 0...3 {
            availableDays.append(Timestamp(
                seconds: confirmedDate.seconds + Int64(secondsInADay * day),
                nanoseconds: 0))
        }
        
        return availableDays
    }
    
    func confirmContribution() {
        CloudFunctionTrigger.shared.getServerTime { serverUnixEpoch in
            let confirmedDate = Timestamp(seconds: Int64(serverUnixEpoch), nanoseconds: 0)
            
            var newData: [AnyHashable: Any] = [:]
            newData["status"] = ContributionStatus.confirmed.rawValue
            newData["confirmedDate"] = confirmedDate
            
            self.contributionRepository.updateContribution(
                id: self.contributionId,
                newData: newData)
        }
    }
    
    func setDeliveryDate(chosenDate: Timestamp) {
        var newData: [AnyHashable: Any] = [:]
        newData["status"] = ContributionStatus.deliverySet.rawValue
        newData["deliveryDate"] = chosenDate
        
        self.contributionRepository.updateContribution(
            id: self.contributionId,
            newData: newData)
    }
    
    func confirmDeliveryDate(chosenDate: Timestamp) {
        var newData: [AnyHashable: Any] = [:]
        newData["status"] = ContributionStatus.deliveryConfirmed.rawValue
        newData["deliveryDate"] = chosenDate
        
        self.contributionRepository.updateContribution(
            id: self.contributionId,
            newData: newData)
    }
    
    func confirmDeliveryFinished() {
        var newData: [AnyHashable: Any] = [:]
        newData["status"] = ContributionStatus.finished.rawValue
        
        self.contributionRepository.updateContribution(
            id: self.contributionId,
            newData: newData)
    }
}
