//
//  MyProjectsViewModel.swift
//  Finewaste
//
//  Created by Kendra Arsena W on 19/11/21.
//

import Combine
import FirebaseFirestore

class MyProjectsViewModel: ObservableObject {
    private var projectRepository = ProjectRepository()
    private var contributionRepository = ContributionRepository()
    
    @Published var projects = [Project]() {
        didSet {
            contributionRepository.$contributions
                .assign(to: \.contributions, on: self)
                .store(in: &cancellables)
            for project in projects {
                contributionRepository.getContributions(projectId: project.id!)
            }
        }
    }
    @Published var contributions = [Contribution]()
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        projectRepository.$projects
            .assign(to: \.projects, on: self)
            .store(in: &cancellables)
        projectRepository.getProjects(poster: "8xayV4ivOsOSqUrNiD0kOHM7jih1")
    }
}
