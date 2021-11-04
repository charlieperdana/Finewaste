//
//  Users.swift
//  Finewaste
//
//  Created by charlie siagian on 03/11/21.
//

import Foundation

struct Users: Identifiable {
    var id: String
    var name: String
    var username: String
    var description: String
    var productService: [String]
    var createdProduct: Int
    var donatedWaste: Int
    var location: Location
    var isBusiness: Bool
          
}


struct Location: Hashable, Codable {
    var latitude: Double
    var longitude: Double
}
