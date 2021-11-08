//
//  ProjectMaterialViewModel.swift
//  Finewaste
//
//  Created by Andrean Lay on 05/11/21.
//

import Combine

class ProjectStatusViewModel: ObservableObject {
    private let materialRepository = ProjectMaterialRepository()
    private let contributionRepository = ContributionRepository()
    private let contributionMaterialRepository = ContributionMaterialRepository()
    
    @Published var materials: [ProjectMaterial] = []
    private var contributedMaterials: [ContributionMaterial] = [] {
        didSet {
            contributedQuantity = self.contributedMaterials.compactMap {
                $0.quantity
            }.reduce(0, +)
            
            materialsNeededToMeetTarget = totalMaterialQuantity - contributedQuantity
        }
    }
    var contributedQuantity = 0
    @Published var totalMaterialQuantity = 0 {
        didSet {
            materialsNeededToMeetTarget = totalMaterialQuantity - contributedQuantity
        }
    }
    @Published var materialsNeededToMeetTarget = 0
    @Published var contributorsQuantity = 0
    @Published var daysToDeadline = 0
    
    private var cancellables: Set<AnyCancellable> = []
    
    init(project: Project) {
        let projectId = project.id ?? "---"
        
        materialRepository.$materials
            .sink { materials in
                var total = 0
                
                materials.forEach { material in
                    total += material.target ?? 0
                }
                
                self.totalMaterialQuantity = total
            }
            .store(in: &cancellables)
        materialRepository.getMaterials(projectId: projectId)
        
        contributionMaterialRepository.$contributionMaterials
            .assign(to: \.contributedMaterials, on: self)
            .store(in: &cancellables)
        
        contributionRepository.$contributions
            .sink { contributions in
                self.contributorsQuantity = contributions.count
                
                if self.contributorsQuantity != 0 {
                    let contributionsIds = contributions.compactMap { $0.id }
                    self.contributionMaterialRepository
                        .getContributionMaterials(contributionIds: contributionsIds)
                }
            }
            .store(in: &cancellables)
        contributionRepository.getContributions(projectId: projectId)
        
        CloudFunctionTrigger.shared.getServerTime { serverTime in
            guard let projectDeadline = project.deadline else {
                return
            }
            
            self.daysToDeadline = TimestampHelper.shared.daysBetween(date1: projectDeadline, date2: serverTime)
        }
    }
}
