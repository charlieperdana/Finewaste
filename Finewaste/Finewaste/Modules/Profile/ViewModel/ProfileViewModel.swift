//
//  ProfileViewModel.swift
//  Finewaste
//
//  Created by charlie siagian on 15/11/21.
//

import Foundation
import Firebase
import CoreLocation

class ProfileViewModel: ObservableObject {
    
    @Published var user = User()
    
    let database = Firestore.firestore()
    
    @Published var myProjectNumber = 0
    
    @Published var myContributionNumber = 0
    
    @Published var locationName = ""
   
    
    init(userId: String){
        self.getSingleUser(userId: userId)
    }
    
    func getSingleUser(userId: String) {
        
        self.database.collection("users").document(userId).addSnapshotListener { snapshot, error in
            
            if error ==  nil {
                
                if let snapshot = snapshot {
                    DispatchQueue.main.async {
                        
                        let userData = snapshot.data()
                        
                        self.getMyProjectNumber(user: userId) { number in
                            self.myProjectNumber = number
                            print("Jumlah:\(number)")
                        }
                        
                        self.getMyContributeNumber(user: userId) { number in
                            self.myContributionNumber = number
                            print("Jumlah Contri:\(number)")
                        }
                        
                        self.user = User(id: userId,
                                    profilePhotoUrl: userData?["profilePhotoUrl"] as? String ?? "",
                                    name: userData?["name"] as? String ?? "",
                                    username: userData?["username"] as? String ?? "",
                                    description: userData?["description"] as? String ?? "",
                                    productServices: userData?["productServices"] as? [String] ?? [""],
                                    createdProducts: userData?["createdProducts"] as? Int ?? 0,
                                    donatedWaste: userData?["donatedWaste"] as? Int ?? 0,
                                    location: userData?["location"] as? GeoPoint ?? GeoPoint(latitude: 0.0, longitude: 0.0),
                                    isBusiness: userData?["isBusiness"] as? Bool ?? false)
                        
                        print("User: \(self.user )")
                        
                    }
                    
                }
            }
            else {
                
                print("Errormya:\(error)")
                
            }
        }
        
    }
    
    func getMyProjectNumber(user: String, completion: @escaping (Int) -> Void){
        
        database.collection("projects").whereField("poster", isEqualTo: user).addSnapshotListener { snapshot, error in
            if error ==  nil {
                
                if let snapshot = snapshot {
                    
                    DispatchQueue.main.async {
                        
                        completion(snapshot.documents.count)
                        
                    }
                    
                }
            }
            else {
                
            }
        }
        
    }
    
    func getMyContributeNumber(user: String, completion: @escaping (Int) -> Void){
        
        var counter = 0
        
        database.collection("contributions").whereField("contributor", isEqualTo: user).addSnapshotListener { snapshot, error in
            if error ==  nil {
                
                if let snapshot = snapshot {
                    
                    DispatchQueue.main.async {
                        
                        snapshot.documents.forEach( { contribution in
                            let documentData = contribution.data()
                            self.database.collection("projects").document(documentData["projectId"] as? String ?? "").addSnapshotListener { snapshot, error in
                                
                                counter += 1
                                
                                completion(counter)
                                
                
                                
                            }
                        })
                        
                    }
                   
                    

                    
                }
            }
            else {
                
            }
        }
        
       
        
    }
    
//    func getLocationName(latitude: Double, longitude: Double) -> String {
//        if let lat = latitude, let long = longitude {
//            let loc = CLLocation(latitude: lat, longitude: long)
//
//            loc.fetchShortLocation { placemark, error in
//                if error != nil {
//                    self.projectLocation = "---"
//                }
//
//                let locality = placemark?.locality ?? "---"
//                let subLocality = placemark?.subLocality ?? "---"
//
//                self.projectLocation = "\(locality), \(subLocality)"
//            }
//        }
//    }
    
    
}
