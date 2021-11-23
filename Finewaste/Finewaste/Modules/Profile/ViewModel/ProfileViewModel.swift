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
    
    @Published var urlProfileImage = ""
    
    private var uploader: CloudStorageUploader?
    
    @Published var productImages = [""]
    
    @Published var uploadedImages = 0
    
    @Published var postingUpdate = false
    
    
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
                                         productServices: userData?["productService"] as? [String] ?? [""],
                                         createdProducts: userData?["createdProducts"] as? Int ?? 0,
                                         donatedWaste: userData?["donatedWaste"] as? Int ?? 0,
                                         location: userData?["location"] as? GeoPoint ?? GeoPoint(latitude: 0.0, longitude: 0.0),
                                         isBusiness: userData?["isBusiness"] as? Bool ?? false,
                                         productImages: userData?["productPictures"] as? [String] ?? [""])
                        
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
                           "profilePhotoUrl":data.profilePhotoUrl ?? "",
                           "location":data.location ?? GeoPoint(latitude: 0.0, longitude: 0.0),
                           "description":data.description ?? "",
                           "isBusiness":data.isBusiness ?? false,
                           "productService":data.productServices ?? [""],
                           "createdProduct":data.createdProducts ?? 0,
                           "donatedWaste":data.donatedWaste ?? 0,
                           "productPictures":data.productImages ?? [""]
        ] as [String : Any]
        database.collection("users").document(data.id ?? "").setData(updatedData, merge: true){ error in
            
            if error == nil {
                
            }
            
        }
    }
    
    
    func uploadProfileImages(image: UIImage, completion: @escaping (String) -> Void) {
        
        var urlResult = ""
        let filename = UUID().uuidString
        guard let uid = AuthenticationHelper.shared.userId
        else { return }
        
        let ref = Storage.storage().reference(withPath: "profile/\(uid)_profile")
        let metadatas = StorageMetadata()
        metadatas.contentType = "image/jpeg"
        
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {return}
        
        ref.putData(imageData, metadata: metadatas){ metadata, err in
            if let err = err {
                print("error bung - \(err.localizedDescription)")
                return
            }
            
            ref.downloadURL { url, err in
                if let err = err {
                    print("error download url - \(err.localizedDescription)")
                    return
                }
                
                if let urlResult = url?.absoluteString {
                    completion(urlResult)
                }

                print("url profile: \(urlResult)")
             
            }
            
        }
        
        
        
    }
    
    func postProductImages(images: [UIImage], completion: @escaping ([String]) -> Void) {

        let imagesData = ImageCompressor.shared.compressImages(images: images)

        let totalImages = imagesData.count
//        var postingUpdate = true
//        self.post(images: imagesData) { [self] in
//            uploadedImages += 1
//
//            if uploadedImages == imagesData.count {
//                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                    self.postingUpdate = false
//                }
//            }
//        }
        
        self.post(images: imagesData, onUpdate: {}, completion: completion)
    }
    
    func post(images: [Data], onUpdate: @escaping () -> Void, completion: @escaping ([String]) -> Void) {
        
        let path = "profile"
        let store = Firestore.firestore()
        
        let ref = store.collection(path).document()
        
        
        uploader = CloudStorageUploader(toUpload: images, onUploadedHandler: onUpdate)
        uploader?.startUpload(atPath: "\(path)/\(ref.documentID)") { imageLinks in
            self.productImages = imageLinks
            print("Linkk :\(imageLinks)")
            print("productImagesnya:\(self.productImages)")
            completion(imageLinks)
        
        }
    }
    
    
    
    
}
