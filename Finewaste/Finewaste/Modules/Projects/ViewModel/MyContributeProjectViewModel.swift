//
//  MyContributeProjectViewModel.swift
//  Finewaste
//
//  Created by charlie siagian on 12/11/21.
//

import Foundation
import Firebase
import SwiftUI

class MyContributeProjectViewModel: ObservableObject {
    
    @Published var listProject = [Project]()
    
    let database = Firestore.firestore()
    
    @Published var listProjectMaterial = [ProjectMaterial]()
    
    @Published var projectTarget = [String:(contribution:Int,target:Int)]()
    
    @Published var daysToDeadline = [String:(Int)]()
    
    private var user: String
    
    
    init(user: String){
        self.user = user
        self.getMyContributeProjectData(user: user)
    }
    
    
    func getMyContributeProjectData(user: String) {
        
        
        database.collection("contributions").whereField("contributor", isEqualTo: user).addSnapshotListener { snapshot, error in
            if error ==  nil {
                
                if let snapshot = snapshot {
                    
                    DispatchQueue.main.async {
                        
                        snapshot.documents.forEach( { contribution in
                            let documentData = contribution.data()
                            self.database.collection("projects").document(documentData["projectId"] as? String ?? "").addSnapshotListener { snapshot, error in
                                
                                let projectData = snapshot?.data()
                                
                                
                                
                                
                                self.listProject.append(Project(id: snapshot?.documentID,
                                                                poster: projectData?["poster"] as? String ?? "",
                                                                projectName: projectData?["projectName"] as? String ?? "",
                                                                description: projectData?["description"] as? String ?? "",
                                                                deadline: projectData?["deadline"] as? Timestamp ?? Timestamp(date: Date(timeIntervalSince1970: 0)),
                                                                images: projectData?["images"] as? [String] ?? [""],
                                                                deliveryType: projectData?["deliveryType"] as? [String] ?? [""],
                                                                location: projectData?["location"] as? GeoPoint ?? GeoPoint(latitude: 0.0, longitude: 0.0)))
                                
                                self.projectTarget[snapshot?.documentID ?? ""] = (contribution:0,target:0)
                                
                                
                                self.getNumberOfContribution(projectId: snapshot?.documentID ?? "") { contribute in
                                    self.projectTarget[snapshot?.documentID ?? ""]?.contribution = contribute
                                    print("Contribute: \(contribute)")
                                }
                                
                                
                                self.getTotalNeeded(projectId: snapshot?.documentID ?? "") { targets in
                                    self.projectTarget[snapshot?.documentID ?? ""]?.target = targets
                                    print("Target: \(targets)")
                                }
                                
                                self.daysToDeadline[snapshot?.documentID ?? ""] = 0
                                
                                self.getDeadline(deadline: (projectData?["deadline"] as? Timestamp) ?? Timestamp(date: Date(timeIntervalSince1970: 0))) { deadline in
                                    self.daysToDeadline[snapshot?.documentID ?? ""] = deadline
                                }
                                
                                
                            }
                        })
                        
                    }
                   
                    

                    
                }
            }
            else {
                
            }
        }
        
        print("List Count : \(self.listProject.count)")
    
        
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
