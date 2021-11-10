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
    
    @Published var listProject = [Project]()
    
    @Published var items = 0..<20
    
    let database = Firestore.firestore()
    
    @Published var contribution = 0
    @Published var target = 0
    
    @Published var listProjectMaterial = [ProjectMaterial]()
    
    @Published var projectTarget = [String:(contribution:Int,target:Int)]()
    
    init(){
        self.getProjectData()
    }
    
    func getProjectData() {
        
        
        
        database.collection("projects").getDocuments { snapshot, error in
            
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
                            
                            
                            return Project(id: docs.documentID,
                                           poster: docs["poster"] as? String ?? "",
                                           projectName: docs["projectName"] as? String ?? "",
                                           description: docs["description"] as? String ?? "",
                                           deadline: docs["deadline"] as? Int ?? 0,
                                           neededMaterials: docs["neededMaterials"] as? [ProjectMaterial] ?? [ProjectMaterial()],
                                           images: docs["images"] as? [String] ?? [""],
                                           deliveryType: docs["deliveryType"] as? [String] ?? [""],
                                           location: docs["location"] as? GeoPoint ?? GeoPoint(latitude: 0.0, longitude: 0.0),
                                           updates: docs["updates"] as? [ProjectUpdate] ?? [ProjectUpdate()])
                            
                        }
                    }
                    
                }
            }
            else {
                
            }
        }
        
    }
    
    
    func getNumberOfContribution(projectId: String, completion: @escaping (Int) -> Void) {
        
        
        database.collection("contributions").whereField("projectId", isEqualTo: projectId).getDocuments { snapshot, error in
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
        
        
        database.collection("projectMaterials").whereField("projectId", isEqualTo: projectId).getDocuments { snapshot, error in
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
    
    
}
