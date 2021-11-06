//
//  ProjectUpdateViewModel.swift
//  Finewaste
//
//  Created by Andrean Lay on 06/11/21.
//

import Combine

class ProjectUpdateViewModel: ObservableObject {
    private var repository = ProjectUpdateRepository()
    @Published var projectUpdates = [ProjectUpdate]()
    
    private var cancellables: Set<AnyCancellable> = []
    
    init(projectId: String) {
        repository.$projectUpdates
            .assign(to: \.projectUpdates, on: self)
            .store(in: &cancellables)
        repository.get(projectId: projectId)
    }
}
