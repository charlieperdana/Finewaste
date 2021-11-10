//
//  NewContributionModel.swift
//  Finewaste
//
//  Created by Andrean Lay on 09/11/21.
//

import FirebaseFirestore

class NewContributionModel: ObservableObject {
    @Published var contributor = ""
    @Published var postId = ""
    @Published var deliveryType = ""
    @Published var location = GeoPoint(latitude: 0, longitude: 0)
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
