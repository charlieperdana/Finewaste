//
//  SetDeliveryViewModel.swift
//  Finewaste
//
//  Created by Andrean Lay on 10/11/21.
//

import Combine
import CoreLocation

class SetDeliveryViewModel: ObservableObject {
    private var repository = ProjectRepository()
    private var project: Project?
    
    @Published var deliveryTypes = [String]()
    var projectLocation: String = ""
    @Published var projectCoordinate: CLLocationCoordinate2D = .init(latitude: -6.175784, longitude: 106.827136)
    @Published var pickUpCoordinate: CLLocationCoordinate2D = .init(latitude: -6.175784, longitude: 106.827136) {
        didSet {
            getAddress(fromCoordinate: pickUpCoordinate) { address in
                self.contributionModel.deliveryAddress = address
            }
            self.contributionModel.location = pickUpCoordinate
        }
    }
    
    @Published var contributionModel: NewContributionModel
    
    private var cancellables: Set<AnyCancellable> = []
    
    init(contributionModel: NewContributionModel) {
        self.contributionModel = contributionModel
        
        repository.$project
            .compactMap { $0 }
            .sink { project in
                self.setProjectData(from: project)
            }
            .store(in: &cancellables)
        repository.get(projectId: contributionModel.projectId)
    }
    
    private func setProjectData(from project: Project) {
        self.project = project
        self.deliveryTypes = project.deliveryType ?? []
        
        let coordinate = CLLocationCoordinate2D(
            latitude: project.location?.latitude ?? 0,
            longitude: project.location?.longitude ?? 0)
        self.projectCoordinate = coordinate
        
        getAddress(fromCoordinate: projectCoordinate) { address in
            self.projectLocation = address
        }
    }
    
    func setContributionDeliveryMethod(method: String) {
        contributionModel.deliveryType = method
        if method == "Drop off" {
            contributionModel.location = projectCoordinate
        } else {
            contributionModel.location = pickUpCoordinate
        }
    }
    
    private func getAddress(fromCoordinate coordinate: CLLocationCoordinate2D, completion: @escaping (String) -> Void) {
        let lat = coordinate.latitude
        let long = coordinate.longitude
        let loc = CLLocation(latitude: lat, longitude: long)
        
        loc.fetchShortLocation { placemark, error in
            if error != nil {
                self.projectLocation = "---"
            }
            
            guard let placemark = placemark else {
                return
            }
            
            completion(self.getFullLocation(placemark: placemark))
        }
    }
    
    private func getFullLocation(placemark: CLPlacemark) -> String {
        let streetName = placemark.name ?? ""
        let subLocality = placemark.subLocality ?? ""
        let locality = placemark.locality ?? ""
        let administrativeArea = placemark.administrativeArea ?? ""
        
        let location = "\(streetName), \(locality), \(subLocality), \(administrativeArea)"
        
        return location
    }
}
