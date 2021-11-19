//
//  OnboardingViewModel.swift
//  Finewaste
//
//  Created by charlie siagian on 05/11/21.
//

import Foundation
import Firebase
import SwiftUI


class UserViewModel: ObservableObject {
    @Published var list = [Users]()
    
    @Published var user = User()
    
    let db = Firestore.firestore()
    
    
    func getData() {
        
        db.collection("users").getDocuments { snapshot, error in
            
            if error ==  nil {
                
                if let snapshot = snapshot {
                    DispatchQueue.main.async {
                        
                        self.list = snapshot.documents.map { docs in
                            
                            return Users(id: docs.documentID,
                                         name: docs["name"] as? String ?? "",
                                         username: docs["username"] as? String ?? "",
                                         description: docs["description"] as? String ?? "",
                                         productService: docs["productService"] as? [String] ?? [""],
                                         createdProduct: docs["createdProduct"] as? Int ?? 0,
                                         donatedWaste: docs["donatedWaste"] as? Int ?? 0,
                                         location: docs["location"] as? Location ?? Location.init(latitude: 0.0, longitude: 0.0),
                                         isBusiness: docs["isBusiness"] as? Bool ?? false)
                        }
                    }
                    
                }
            }
            else {
                
                print(error)
                
            }
        }
        
    }
    
    func addData(newUser: Users) {
        
        
        let uuid = newUser.id
        
        db.collection("users").document(uuid).setData(["name":newUser.name,
                                                       "username":newUser.username,
                                                       "description":newUser.description,
                                                       "productService":newUser.productService,
                                                       "createdProduct":newUser.createdProduct,
                                                       "donatedWaste":newUser.donatedWaste,
                                                       "location":GeoPoint(latitude: newUser.location.latitude,longitude: newUser.location.longitude),
                                                       "isBusiness":newUser.isBusiness]) { error in
            
            if error == nil {
                
                self.getData()
            }
            else {
                print(error)
            }
        }
    }
    
    func checkUsername(username: String, completion: @escaping (Bool) -> Void) {
        
        let collectionUser = db.collection("users")

        collectionUser.whereField("username", isEqualTo: username).getDocuments { (snapshot, err) in
            if let err = err {
                print("Error getting document: \(err)")
            } else if (snapshot?.isEmpty)! {
                completion(false)
            } else {
                for document in (snapshot?.documents)! {
                    if document.data()["username"] != nil {
                        completion(true)
                    }
                }
            }
        }
    }
    
    
}
