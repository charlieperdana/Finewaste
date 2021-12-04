//
//  NewContributionModel.swift
//  Finewaste
//
//  Created by Andrean Lay on 09/11/21.
//

import FirebaseFirestore
import CoreLocation

class NewContributionModel: ObservableObject {
    @Published var contributorId = ""
    @Published var projectName = ""
    @Published var projectId = ""
    @Published var projectOwnerId = ""
    @Published var projectOwnerUsername = ""
    @Published var projectOwnerPhotoUrl = ""
    @Published var deliveryAddress = ""
    @Published var deliveryType = ""
    @Published var location = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    @Published var materials = [NewContributionMaterialModel]()
}

class NewContributionMaterialModel: ObservableObject {
    @Published var contributionId = ""
    @Published var materialId = ""
    @Published var materialName = ""
    @Published var quantity = -1
    @Published var requirements = [String]()
    @Published var images = [UIImage]()
}
