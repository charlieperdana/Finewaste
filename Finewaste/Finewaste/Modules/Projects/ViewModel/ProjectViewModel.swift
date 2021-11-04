//
//  ProjectViewModel.swift
//  Finewaste
//
//  Created by charlie siagian on 04/11/21.
//

import Foundation
import Firebase
import SwiftUI

class ProjectViewModel: ObservableObject {
    
    @Published var list = [Users]()
    
   
    func getData() {
        
//        referense to db
        let db = Firestore.firestore()
        
//        read doc at a spesific path
        db.collection("users").getDocuments { snapshot, error in
            
            //            check for error
            if error ==  nil {
                // no error
                
                if let snapshot = snapshot {
                    
                    //                    karena fecth data di background, kita mau buat di foreground
//                    update the list in the main thread
                    DispatchQueue.main.async {
                        
                        //                    get all doc and create users
                        self.list = snapshot.documents.map { docs in
                            
//                            create a users doc for each doc
//                            return Users(fullname: docs["fullname"] as? String ?? "",
//                                         username: docs["username"] as? String ?? "",
//                                         uuid: docs["uuid"] as? String ?? "",
//                                         id: docs.documentID)
                            
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
                //                handle errornya
//                print(error)
                print("cinta")
                
            }
        }
        
    }
    
    func addData(newUser: Users) {
        
        let db = Firestore.firestore()
        
        let username = newUser.username
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
//                print(error)
                print("cinta")
            }
        }
    }
}
