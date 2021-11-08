//
//  ProjectDetailViewModel.swift
//  Finewaste
//
//  Created by Andrean Lay on 02/11/21.
//

import Combine
import CoreLocation

class ProjectDetailViewModel: ObservableObject {
    @Published var projectRepository = ProjectRepository()
    @Published var projectMaterialRepository = ProjectMaterialRepository()
    
    @Published var project: Project? {
        didSet {
            self.getLocationName()
        }
    }
    @Published var projectId = ""
    @Published var projectLocation = ""
    @Published var projectMaterials = [ProjectMaterial]()
    
    private var cancellables: Set<AnyCancellable> = []
    
    init(projectId: String) {
        projectMaterialRepository.$materials
            .assign(to: \.projectMaterials, on: self)
            .store(in: &cancellables)
        
        projectRepository.$project
            .compactMap { $0 }
            .sink { project in
                self.project = project
                self.projectId = project.id ?? "---"
                self.projectMaterialRepository.getMaterials(projectId: project.id ?? "---")
            }
            .store(in: &cancellables)
        projectRepository.get(projectId: projectId)
    }
    
    func getLocationName() {
        if let lat = project?.location?.latitude, let long = project?.location?.longitude {
            let loc = CLLocation(latitude: lat, longitude: long)
            
            loc.fetchShortLocation { placemark, error in
                if error != nil {
                    self.projectLocation = "---"
                }
                
                let locality = placemark?.locality ?? "---"
                let subLocality = placemark?.subLocality ?? "---"
                
                self.projectLocation = "\(locality), \(subLocality)"
            }
        }
    }
    
    func getDeliveryTypes() -> String {
        return project?.deliveryType?.joined(separator: ", ") ?? "---"
    }
}
