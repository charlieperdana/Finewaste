//
//  ProfileViewModel.swift
//  Finewaste
//
//  Created by charlie siagian on 15/11/21.
//

import Foundation
import Firebase
import CoreLocation
import UIKit

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
                        
                        let location = userData?["location"] as? GeoPoint ?? GeoPoint(latitude: 0.0, longitude: 0.0)
                        
                        self.getLocationName(latitude: location.latitude, longitude: location.longitude) { value in
                            self.locationName = value
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
                            self.database.collection("projects").document(documentData["projectId"] as? String ?? "").addSnapshotListener { _, _ in
                                
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
    
    func getLocationName(latitude: Double, longitude: Double, completion: @escaping (String) -> Void) {
        var location = ""
        let loc = CLLocation(latitude: latitude, longitude: longitude)
        
        loc.fetchShortLocation { placemark, error in
            if error != nil {
                location = "---"
            }
            
            let locality = placemark?.locality ?? "---"
            let subLocality = placemark?.subLocality ?? "---"
            
            location = "\(locality), \(subLocality)"
            
            completion(location)
        
        }
    }
    
    func updateProfile(data: User){
        let updatedData = ["name":data.name ?? "",
                           "username":data.username ?? "",
                           "location":data.location ?? GeoPoint(latitude: 0.0, longitude: 0.0),
                           "description":data.description ?? "",
                           "isBusiness":data.isBusiness ?? false,
                           "productService":data.productServices ?? [""]
        ] as [String : Any]
        database.collection("users").document(data.id ?? "").setData(updatedData, merge: true){ error in
            
            if error == nil {
                
            }
            
        }
    }
    
    func uploadProfileImage(image: UIImage){
        if let imageData = image.jpegData(compressionQuality: 1){
            let storage = Storage.storage()
            storage.reference().child("profile").putData(imageData, metadata: nil){ (_,err)  in
                if let err = err {
                    print("error bung - \(err.localizedDescription)")
                } else {
                    print("gambar uploaded")
                }
            }
        } else {
            print("couldn't unwrap/case image to data")
        }
    }
    
    
}
