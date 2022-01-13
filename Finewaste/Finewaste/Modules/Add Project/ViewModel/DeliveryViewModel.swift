//
//  DeliveryViewModel.swift
//  Finewaste
//
//  Created by Kendra Arsena W on 16/11/21.
//

import Foundation
import CoreLocation
import FirebaseFirestore

class DeliveryViewModel: ObservableObject {
    private var projectRepository = ProjectRepository()
    private var projectMaterialRepository = ProjectMaterialRepository()
    
    var projectLocation: String = ""
    var isLocationSelected: Bool = false
    
    var publishedImage = 0
    
    @Published var pickUpCoordinate: CLLocationCoordinate2D = .init(latitude: -6.175784, longitude: 106.827136) {
        didSet {
            isLocationSelected = true
            getAddress(fromCoordinate: pickUpCoordinate) { address in
                self.projectModel.deliveryAddress = address
//                print("halo: \(address)")
            }
            self.projectModel.location = GeoPoint(latitude: pickUpCoordinate.latitude, longitude: pickUpCoordinate.longitude)
        }
    }
    
    @Published var projectModel = NewProjectModel()
    
    init() {}
    
    func postProject(newProject: NewProjectModel) {
        let project = Project(
            poster: AuthenticationHelper.shared.userId,
            posterUsername: AuthenticationHelper.shared.username,
            posterPhotoUrl: AuthenticationHelper.shared.profilePhotoUrl,
            projectName: newProject.projectName,
            description: newProject.projectDesc,
            deadline: newProject.deadline,
            deliveryType: newProject.deliveryType,
            location: newProject.location)
        
        let compressedImage = ImageCompressor.shared.compressImages(images: newProject.images)
        self.projectRepository.postProject(project: project, images: compressedImage) {
            self.publishedImage += 1
            
            if self.publishedImage == newProject.images.count {
                
            }
        } completion: { docId in
            var materials = [ProjectMaterial]()
            for material in newProject.newMaterial {
                materials.append(ProjectMaterial(
                    projectId: docId,
                    name: material.materialName,
                    target: material.materialTarget,
                    allowOverlimit: material.allowOverlimit,
                    prerequisite: material.materialPrerequisite))
            }
            for index in materials.indices {
                self.projectMaterialRepository.postProjectMaterial(material: materials[index])
            }
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
