//
//  MyProjectViewModel.swift
//  Finewaste
//
//  Created by charlie siagian on 11/11/21.
//

import Firebase
import SwiftUI

class MyProjectViewModel: ObservableObject {
    
    @Published var listProject = [Project]()
    
    let database = Firestore.firestore()
    
    @Published var listProjectMaterial = [ProjectMaterial]()
    
    @Published var projectTarget = [String:(contribution:Int,target:Int)]()
    
    @Published var daysToDeadline = [String:(Int)]()
    
    private var user: String
    
    
    init(user: String){
        self.user = user
        self.getMyProjectData(user: user)
    }
    
    
    func getMyProjectData(user: String) {
        
        database.collection("projects").whereField("poster", isEqualTo: user).addSnapshotListener { snapshot, error in
            if error ==  nil {
                
                if let snapshot = snapshot {
                    
                    DispatchQueue.main.async {
                        
                        self.listProject = snapshot.documents.map { docs in
                            
                            
                            self.projectTarget[docs.documentID] = (contribution:0,target:0)
                            
                            
                            self.getNumberOfContribution(projectId: docs.documentID) { contribute in
                                self.projectTarget[docs.documentID]?.contribution = contribute
                                print("Contribute: \(contribute)")
                            }
                            
                            
                            self.getTotalNeeded(projectId: docs.documentID) { targets in
                                self.projectTarget[docs.documentID]?.target = targets
                                print("Target: \(targets)")
                            }
                            
                            self.daysToDeadline[docs.documentID] = 0
                            
                            self.getDeadline(deadline: (docs["deadline"] as? Timestamp) ?? Timestamp(date: Date(timeIntervalSince1970: 0))) { deadline in
                                self.daysToDeadline[docs.documentID] = deadline
                            }
                            
                            
                            return Project(id: docs.documentID,
                                           poster: docs["poster"] as? String ?? "",
                                           projectName: docs["projectName"] as? String ?? "",
                                           description: docs["description"] as? String ?? "",
                                           deadline: docs["deadline"] as? Timestamp ?? Timestamp(date: Date(timeIntervalSince1970: 0)),
                                           images: docs["images"] as? [String] ?? [""],
                                           deliveryType: docs["deliveryType"] as? [String] ?? [""],
                                           location: docs["location"] as? GeoPoint ?? GeoPoint(latitude: 0.0, longitude: 0.0))
                            
                        }
                    }
                    
                }
            }
            else {
                
            }
        }
        
        print("Count: \(self.daysToDeadline.count)")
        
    }
    
    
    func getNumberOfContribution(projectId: String, completion: @escaping (Int) -> Void) {
        
        
        database.collection("contributions").whereField("projectId", isEqualTo: projectId).addSnapshotListener { snapshot, error in
            if error ==  nil {
                if let snapshot = snapshot {
                    DispatchQueue.main.async {
                        
                        completion(snapshot.documents.count)
                        
                    }
                    
                } else {
                    print("error")
                }
            }
            
        }
        
    }
    
    
    func getTotalNeeded(projectId: String, completion: @escaping (Int) -> Void){
        
        
        database.collection("projectMaterials").whereField("projectId", isEqualTo: projectId).addSnapshotListener { snapshot, error in
            if error ==  nil {
                if let snapshot = snapshot {
                    DispatchQueue.main.async {
                        
                        var target = 0
                        
                        snapshot.documents.forEach { docs in
                            
                            
                            target += docs["target"] as? Int ?? 0
                            
                            
                        }
                        
                        
                        completion(target)
                        
                        
                    }
                    
                } else {
                    print("error")
                }
            }
            
        }
        
    }
    
    func getDeadline(deadline: Timestamp, completion: @escaping (Int) -> Void){
        
        
        CloudFunctionTrigger.shared.getServerTime { serverTime in
            guard let projectDeadline = deadline as? Timestamp else {
                return
            }
            
            
            completion(TimestampHelper.shared.daysBetween(date1: projectDeadline, date2: serverTime))
            
        }
        
    }
    
    
    
}
